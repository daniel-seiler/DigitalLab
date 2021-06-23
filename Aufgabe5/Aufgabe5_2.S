/*
 *Aufgabe 5.2
 *
 *  Created on: 15.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */

.equ IODIR1, 0xE0028018

.equ IOSET1, 0xE0028014

.equ IOCLR1, 0xE002801C

.code 32 /* Select ARM instruction set */

.global main /* Specify global symbol */
main:

//Aufgabe 5_2

// R0 Bit MUSTER
// R1 IODR pointer
// R2 IOSET1 Pointer
// R3 IOCLR1 Pointer

	ldr sp, =0x40001000
	ldr r1, =IODIR1
	ldr r2, =IOSET1
	ldr r3, =IOCLR1
	ldr r0, =0x00ff0000
	str r0, [r1]
	ldr r0, =0x10000

led_loop:
	str r0, [r2]
	bl delay

	str r0, [r3]
	mov r0, r0, lsl #1

	cmp r0, #0x01, 8
	ldreq r0, =0x10000
	b led_loop

delay:
	stmfd sp!, {r8, lr}
	ldr r8, =0x100000

wait:
	subs r8, #1
	bne wait

	ldmfd sp!, {r8, pc}

stop:
nop
bal stop

.end
