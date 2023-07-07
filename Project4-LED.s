//
// User LD3: The green LED is a user LED connected to the I/O PG13 of the STM32F429ZIT6.
// User LD4: The red LED is a user LED connected to the I/O PG14 of the STM32F429ZIT6.
//

	.syntax     unified
	.cpu        cortex-m4
	.equ RCC_AHB1ENR, 0x40023830
    .equ GPIOG_MODER, 0x40021800
    .equ GPIOG_OTYPER,0x40021804
    .equ GPIOG_OSPEEDR,0x40021808
    .equ GPIOG_IDR,   0x40021810
    .equ GPIOG_ODR,   0x40021814

	.text

//
// Function to set up bits 14 and 13 of the GPIO port G to drive the
// red and green user LEDs. The bits are set to general purpose output
// mode with high speed. There are no arguments or a return value.
//
	.global		setupLEDs
	.thumb_func
	.align
setupLEDs:
// Complete your assembly code hereDone
ldr r2, =RCC_AHB1ENR
	ldr r1, [r2]
	orr r1, 0x00000040 ///Designed from the G diagram
	str r1, [r2]

    ldr r2, =GPIOG_MODER
	ldr r1, [r2]
	BIC r1, 0x3C000000 ///Designed from the G diagram14
	ORR r1, 0x14000000 //orr forces it to 1
	str r1, [r2]

	// 29-26 set to 1111
	 ldr r2, = GPIOG_OSPEEDR
	ldr r1, [r2]
	ORR r1, 0x3C000000 
	str r1, [r2]
	
	bx	lr

//
// Function to set the state of the two user LEDs. There are
// two uint32_t arguments expected. The first argument controls
// the green LED on bit 13 of GPIO port G, and the second argument
// controls the red LED on bit 14 of GPIO port G. Each argument
// may be 0 or 1, signifying the corresponding LED is turned on
// or off, respectively. There is no return value.




	.global		setLEDs
	.thumb_func
	.align
setLEDs:
// Complete your assembly code here


//13
Mov R2, #0 // r2 is cleared out 
LDR R3, =GPIOG_ODR//preparing register to write to memory location
TST R0, 0x01 //test if 0 or 1 testing for the 0 flag if 
IT NE //its at 1
MOVNE R2, 0x00002000


//14
TST R1, 0x01
IT NE //it is 1 
ORRNE R2, #0x00004000 

STR R2, [R3]
//13GPIO 1 
//14 GPIO 2 
	bx	lr
	.end
