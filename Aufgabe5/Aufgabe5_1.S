/*
 *Aufgabe 5.1
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */

.equ IOPIN0, 0xE0028000

.equ IODIR1, 0xE0028018

.equ IOSET1, 0xE0028014

.equ IOCLR1, 0xE002801C

.code 32 /* Select ARM instruction set */

.global main /* Specify global symbol */
main:

//Aufgabe 5_1

// R0 Bit MUSTER
// R1 IODR pointer
// R2 IOSET1 Pointer
// R3 Counter (LED amount)

	ldr sp, =0x40001000
	ldr r3, =LED_AMOUNT
	ldr r1, =IODIR1
	ldr r0, =0x00ff0000
	str r0, [r1]
	ldr r0, =0x10000

led_loop:
	ldr r2, =IOSET1
	str r0, [r2]
	mov r0, r0, lsl #1
	bl delay

	cmp r0, #0x01, 8
	bne led_loop

stop:
nop
bal stop

delay:
	stmfd sp!, {r8, lr}
	ldr r8, =0xFFFFFF

wait:
	subs r8, #1
	bne wait

	ldmfd sp!, {r8, pc}

.end

