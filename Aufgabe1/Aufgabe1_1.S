/*
 * Aufgabe_1_1.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.data
var1: .word 3
var2: .word 4

.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:
ldr r0, =var1
	mov r0, #25
	mov r1, #204
	add r2, r0, r1

stop:
nop
bal stop
.end
