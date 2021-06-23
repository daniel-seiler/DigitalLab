/*
 * Aufgabe 4_2.S
 *
 *  Created on: 23.10.2020
 *      Author: Daniel Seiler
 */


  .data
 .global datastart
datastart:
variable_a:
.word 0x80000000
.word 0x80000001

variable_b:
.word 0xA0000002
.word 0x70000003


.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	ldr sp, =0x40001000
	ldr r0, =variable_a
	ldr r1, =variable_b

	bl add64

stop:
nop
bal stop

add64:
	stmfd sp!, {r5-r6, lr}

	ldr r5, [r0]
	ldr r6, [r1], #4
	adds r5, r6
	str r5, [r0], #4
	ldr r5, [r0]
	ldr r6, [r1]
	adcs r5, r6
	str  r5, [r0], #-4

	ldmfd sp!, {r5-r6, pc}

.end

