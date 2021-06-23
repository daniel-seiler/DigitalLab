/*
 * Aufgabe 2_1.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */

var_a:
.word 4294967290

var_b:
.word 4294967290

var_c:
.word 5

var_d:
.word 10

.global _startup /* Specify global symbol */
_startup:

	ldr r0, #var_a
	ldr r1, #var_b

	ldr r2, #var_c
	ldr r3, #var_d

	adds r6, r1, r3
	bcc noCarry1
	mov r4, #1

noCarry1:

	adds r7, r0, r2
	bcc noCarry2
	mov r5, #1

noCarry2:

	adds r7, r4
	movcs r5, #1

stop:
nop
bal stop
.end
