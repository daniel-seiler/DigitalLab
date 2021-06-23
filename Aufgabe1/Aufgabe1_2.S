/*
 * Aufgabe_1_2.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */

var_a:
.word 25

var_b:
.word 204

.global _startup /* Specify global symbol */
_startup:

	ldr r0, #var_a
	ldr r1, #var_b
	add r2, r0, r1

stop:
nop
bal stop
.end
