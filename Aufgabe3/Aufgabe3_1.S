/*
 * Aufgabe 3_1.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
 .data
 .global datastart
datastart:
var_a:
.word 0x11111111
var_b:
.word 0x22222222
var_c:
.word 0x33333333
var_d:
.word 0x44444444
var_e:
.word 0x555F5555

.text /* Specify that code goes in text segment */

.equ NUMVALS, 5

.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	ldr sp, =0x40001000
	mov r3, #NUMVALS
	mov r4, #0
	mov r5, #0
	ldr r6, =datastart

loop:
	ldr r7, [r6], #4

	adds r4, r7
	addcs r5, #1

	bl delay

	subs r3, #1

	bne loop

stop:
nop
bal stop

delay:
	stmfd sp!, {r8, lr}
	ldr r8, =5

wait:
	subs r8, #1
	bne wait

	ldmfd sp!, {r8, pc}

.end

