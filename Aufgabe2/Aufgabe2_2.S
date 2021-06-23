/*
 * Aufgabe2_2.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */

.code 32 /* Select ARM instruction set */

var_a:
.word 0x123456   // global variable

var_b:
.word 2

.global _startup /* Specify global symbol */
_startup:
// R0 variable A
// R1 variable B
// R2 Low
// R3 High

	ldr r0, #var_a
	ldr r1, #var_b

	mov r2, #0
	mov r3, #0

addA:

	movs r1, r1
	beq stop

	adds r2, r0

	addcs r3, #1

	sub r1, #1

	b addA


stop:
nop
bal stop
.end

/*
 * Abbruchbedingung am Ende:	Nein, da für den Fall R1 = 0 nicht R2 = 0 errechnet werden würde, sondern R2 = R0
 */
