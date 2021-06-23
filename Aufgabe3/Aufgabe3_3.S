/*
 * Aufgabe3_3.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	ldr sp, =0x40001000
	mov r0, #8
	mov r1, #0

	bl start_div

stop:
nop
bal stop



// R0 - dividend
// R1 - divisor
// R2 - error
// r3
// R4 - Quotient

start_div:
	stmfd sp!, {r4, lr}

	movs r1, r1

	moveq r2, #1
	beq end_div

div32:

	add r4, #1
	subs r0, r1
	bcs div32

	add r0, r1
	sub r4, #1
	mov r1, r4

end_div:
	ldmfd sp!, {r4, pc}

.end

