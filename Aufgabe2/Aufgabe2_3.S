/*
 * Beispiel.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */

//R7 saves values copied from registers (instead of R6)
//R6 is pointer to the register (instead of R5)
//R5 stores the carry values from R4

.text /* Specify that code goes in text segment */

.equ NUMVALS, 5

.code 32 /* Select ARM instruction set */


.global datstart
datstart:
//.word 0x12345678

.global _startup /* Specify global symbol */
_startup:

	mov r3, #NUMVALS
	mov r4, #0
	mov r5, #0
	ldr r6, =datstart

loop:
	ldr r7, [r6], #4

	adds r4, r7
	addcs r5, #1

	subs r3, #1

	bne loop

stop:
nop
bal stop
.end

