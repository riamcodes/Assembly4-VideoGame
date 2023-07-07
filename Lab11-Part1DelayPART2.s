		.syntax     unified
		.cpu        cortex-m4

		.text
		.global		delay
		.thumb_func
		.align
delay:
		ldr		r1, =#10000
		mul		r0, r1
loop:
		
// Insert several more 'nop' instructions here,
// or create a repeated block of 'nop' instructions
// with the .rept and .endr assembly directives
.rept 15// used to be 16 subtract 1 
nop// one cycle is 18 instructions or 180,000 miliseconds so since there are already 2 instructions at the bottom to make it a full cycle add 16
.endr
		
		subs	r0, #1// this is like one nop
		bgt		loop //this is also like one nop except it takes more time since its evaluating other stuff and thats why ite is superior
		bx		lr


// add pixel function 
	.global		pixel
    .thumb_func
    .align
// Draws the pixel word passed in R2 to the pixel location given by the
// column in R0 and the row in R1

//leaf
pixel:
// Your assembly code goes here
//R0 contains column
//R1 contains row 
//R2 contains pixel color


MOV R3, #240 // store 240 from the formula
MUL R1, R3   //multiply 240 and row 
ADD R1, R0 // Add the column from the column given to the row 
LDR R0, =0xD0000000 //memory adress from formula to R1 //
// color  already in R2
   

     



STR R2, [R0, R1, LSL #2] // This multiplies R1 by 4 and then adds R1 and R0 memory adress and stores it in R3 ( R1 is the offset of passed in by the row+column)
 
 bx lr


//add rect function
	.global		rect
    .thumb_func
    .align
// Fills in a rectangle with the pixel word passed in R0.
// The rectangle fills all pixels between (column,row) coordinates
// of (50,150) to (149,249), inclusive.


//nonleaf
rect: //??? pass the parameter color???


PUSH {R4, R5, R6, lr} //Give ownership of new registers to functions
MOV R6, R0 // Move the argument in R0 to R6

MOV R4, #150// put this outside the loop top left row

loop1:
//loop body
MOV R5, #50 //inside outer loop top left column

loop2:
//nested loop body
//Pixel(col,row,color)???
MOV R1, R4  //similar to adding parameters to a function change the values passed to the pixel to some registers owned by the function
MOV R0, R5
MOV R2, R6 //color move 

bl pixel


ADD R5, #1


CMP R5, #150
blo loop2
ADD R4, #1


CMP R4, #250 //while row is less than 250
blo loop1

POP {R4, R5, R6, pc}

// Your assembly code goes here
	bx		lr




		.end
