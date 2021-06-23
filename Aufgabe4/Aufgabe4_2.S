/*
 * Aufgabe 4_2.S
 *
 *  Created on: 23.10.2020
 *      Author: Daniel Seiler
 */


  .data
 .global datastart
datastart:

.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

//Aufgabe 4

	ldr r0, =0x99999999
	ldr r1, =0x3
	bl addBCD


stop:
nop
bal stop

// R0	A
// R1	B
// R2	actual A
// R3	actual b
// R4	Count
// R5 	Maske
// R6 	BCD_cy
// R7 	Result
// R8


addBCD:
	stmfd sp!, {r4-r9, lr}

	mov r4, #8
	mov r5, #0x0f
	mov r7, #0
	mov r6, #0

startwhile:

	and r2, r0, r5
	and r3, r1, r5
	add r2, r3
	add r2, r6
	subs r2, #0x0A

	mov r6, #1
	addmi r2, #0x0A
	movmi r6, #0

	add r7, r2
	mov r0, r0, ror #4
	mov r1, r1, ror #4
	mov r7, r7, ror #4
	subs r4, #1
	bne startwhile


	mov r2, r0
	mov r3, r1
	mov r0, r6
	mov r1, r7

	ldmfd sp!, {r4-r9, pc}


.end

