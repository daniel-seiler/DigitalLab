/*
 * Aufgabe_1_3.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */

var_a:
.word 1

.global _startup /* Specify global symbol */
_startup:

	ldr r0, #var_a

loop:

	add r1, r0

	b loop

stop:
nop
bal stop
.end
