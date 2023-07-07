		.syntax     unified
		.cpu        cortex-m4

		.data
state:	.word	0x01	// static variable to hold state of pseudorandom generator

		.text
		.global		seed_random
		.thumb_func
		.align
seed_random:
		ldr		r1, =state	// point to random state
		str		r0, [r1]	// set random state
		bx		lr

		.global		random
		.thumb_func
		.align
random:
// Complete this function with your assembly code

	 LDR R1, =state  //need to reload the state into R1
     LDR R0, [R1]    //Put R1 into R2
     LSLS R0, #1     //Left Shift R0 by 1


	 LDR R2, =0x1D872B41  //Magic number provided in slide 19

	 IT CS          //if the carry is set then
	 EORCS R0, R2   //Exclusive Or the Bits 

	 
	 STR R0, [R1]  //Store R0 into R1
	
		bx		lr
		.end
