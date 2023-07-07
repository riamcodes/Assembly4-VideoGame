//
// The user push button is connected to the I/O PA0 of the STM32F429ZIT6.
//

	.syntax     unified
	.cpu        cortex-m4
	.equ RCC_AHB1ENR,	0x40023830
    .equ GPIOA_MODER,	0x40020000
    .equ GPIOA_PUPDR,	0x4002000C
    .equ GPIOA_IDR,		0x40020010

	.text

//
// Function to set up bit 0 of the GPIO port A to read the
// blue user push button state. The bit is set to input mode
// with a pull-down enabled. There are no arguments or a
// return value.
//
	.global		setup_button
	.thumb_func
	.align
setup_button:
// Complete your assembly code here Done!!!!!!!!!!!!!
ldr r2, =RCC_AHB1ENR
	ldr r1, [r2]
	orr r1, 0x00000001 ///got this from the a diagram designed 
	str r1, [r2]


	ldr r2, = GPIOA_MODER
	ldr r1, [r2]
	BIC r1, 0x00000003
	//orr r1, 0x00000001 ///got this from the a diagram designed 
	//BIC r1, 0x00000003 ///got this from the a diagram designed 
	str r1, [r2]

	ldr r2, = GPIOA_PUPDR
	ldr r1, [r2]
	BIC r1, 0x00000003
	ORR r1, 0x00000002
	str r1, [r2]

	bx	lr

//
// Function to read the current state of the blue user push button
// connected to bit 0 of GPIO port A. The bit will read 0 for a
// released button and 1 for a pressed button. There are no function
// arguments. The uint32_t return value is 0 for released, 1 for
// pressed.
//
	.global		button
	.thumb_func
	.align
button:
// Complete your assembly code here this works 
LDR R1, =GPIOA_IDR
LDR R0, [R1]
TST R0, 0x01
ITE NE
MOVNE R0, #1
MOVEQ R0, #0


	bx	lr

//
// Function to wait indefinitely for the blue user push button
// to be pressed.  There are no arguments or a return value.
//
	.global		wait_for_press
	.thumb_func
	.align
wait_for_press:
// Complete your assembly code here

loopwhile:

LDR R1, =GPIOA_IDR
LDR R0, [R1]
TST R0, 0x01 //  test if its 0
//IT NE //if it is one break out of the loop dont need 
bNE ends



//something to break out of the loop
b loopwhile

ends:
	bx	lr

//
// Function to wait indefinitely for the blue user push button
// to be released.  There are no arguments or a return value.
//
	.global		wait_for_release
	.thumb_func
	.align
wait_for_release:

loopwhiles:

LDR R1, =GPIOA_IDR
LDR R0, [R1]
TST R0, 0x01 //  test if its 0
//IT EQ //if it is 0 break out of the loop 
bEQ endss



//something to break out of the loop
b loopwhiles

endss:

	bx	lr
	.end
