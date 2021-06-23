/*
 * Aufgabe_1_4.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */

var_a:
.word 1

close_to_max:
.word 4294967290

.global _startup /* Specify global symbol */
_startup:

	ldr r0, #var_a
//	ldr r1, #close_to_max

loop:
	mov r2, r1
	adds r1, r0
	bcc loop


stop:
nop
bal stop
.end

/*
 * Taktfrequenz:	122,471 KHz
 * Maximalwert:		4294967295
 *
 * Maximalwerte:
 * 		32bit:		4294967295	= 0xFFFFFFFF
 *		16bit:		65535		= 0xFFFF
 *		8bit:		255			= 0xFF
 */
