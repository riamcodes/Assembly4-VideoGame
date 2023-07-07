#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include "library.h"
#include "graphics.h"

extern void seed_random(uint32_t);
extern uint32_t random(void);
extern void setupLEDs(void);
extern void setLEDs(uint32_t,uint32_t);
extern void setup_button(void);
extern uint32_t button(void);
extern void wait_for_press(void);
extern void wait_for_release(void);
extern void delay(uint32_t);

typedef struct
    {
    const uint8_t *     table ;
    const uint16_t      Width ;
    const uint16_t      Height ;
    } sFONT ;

extern sFONT Font8,Font12,Font16,Font20,Font24;
extern void BSP_LCD_SetFont(sFONT *);
uint32_t delay_time[5] = {75,50,40,35,30};
char buffer[50];

int main(void) {
  uint32_t r;
  int32_t level,i,j,ig,jg,k,m,n;
  sFONT *font;

  InitializeHardware(HEADER,"Green Square Game");
  seed_random(0x5A5A5A5A);  // Seed the random bit generator
  setupLEDs();  // Configure the GPIO port G bits for driving the LEDs
  setup_button();  // Configure the GPIO port A bits for reading the push button
  level = 0;
  setLEDs(0,0);
  font = &Font16;
//  font = &Font20;
//  font = &Font24;
  BSP_LCD_SetFont(font);
  i = -1;
  n = 0;
  while (1) {
    snprintf(buffer,50,"Level %lu",level + 1);
    SetForeground(COLOR_BLACK);
    DisplayStringAt(10,50,buffer);
    if (i >= 0) {
      SetForeground(COLOR_WHITE);
      FillRect(5 + i * 60,70 + j * 60,40,40);
    }
    r = random();
    i = (r & 0x0030) >> 4;
    j = (r & 0x0300) >> 8;
    if (n == 0) {
      ig = (r & 0x00C0) >> 6;
      jg = (r & 0x0C00) >> 10;
      n = 20;
    }
    if (i == ig && j == jg) SetForeground(COLOR_GREEN);
    else SetForeground(COLOR_RED);
    FillRect(5 + i * 60,70 + j * 60,40,40);
    n--;
    k = 0;
    while (k < 10) {
      delay(delay_time[level]);
      if (button()) {
        wait_for_release();
        if (i == ig && j == jg) {
          if (level >= 4) {
            while (1) {
              setLEDs(1,0);
              delay(100);
              setLEDs(0,1);
              delay(100);
            }
          }
          else {
            m = 0;
            while (m < 5) {
              setLEDs(1,0);
              delay(100);
              setLEDs(0,0);
              delay(100);
              m++;
            }
          }
          level++;
          break;
        }
        else {
          m = 0;
          while (m < 5) {
            setLEDs(0,1);
            delay(100);
            setLEDs(0,0);
            delay(100);
            m++;
          }
          break;
        }
      }
      k++;
    }
  }
}
