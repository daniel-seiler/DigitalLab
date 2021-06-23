/*
 *Aufgabe 5.3
 *
 *  Created on: 15.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */

.equ BUTTON_1, (1<<10)
.equ BUTTON_2, (1<<11)
.equ BUTTON_3, (1<<12)
.equ BUTTON_4, (1<<13)

.equ IOPIN0, 0xE0028000
.equ IODIR1, 0xE0028018
.equ IOSET1, 0xE0028014
.equ IOCLR1, 0xE002801C


.code 32 /* Select ARM instruction set */

.global main /* Specify global symbol */
main:

//Aufgabe 5_1

// R0 Bit MUSTER
// R1 IODR1 pointer
// R2 IOSET1 Pointer
// R3 IOCLR1 Pointer
// R4 IOPIN0 Pointer
// R5 BUTTON_1 Maske Taste 1
// R6 BUTTON_2 Maske Taste 2
// R7 BUTTON_3 Maske Taste 3
// R8 BUTTON_4 Maske Taste 4

	ldr r0, =0x00ff0000
	ldr r1, =IODIR1
	ldr r2, =IOSET1
	ldr r3, =IOCLR1
	ldr r4, =IOPIN0
	ldr r5, =BUTTON_1
	ldr r6, =BUTTON_2
	ldr r7, =BUTTON_3
	ldr r8, =BUTTON_4
	str r0, [r1]

loop:
	bl read_button_1
	bl read_button_2
	bl read_button_3
	bl read_button_4

	b loop

stop:
nop
bal stop

read_button_1:
	stmfd sp!, {lr}

	mov r9, #(1<<16)
	ldr r0, [r4]
	ands r0, r5, r0
	beq noled1

	str r9, [r2]
	mov r9, r9, lsl #1
	str r9, [r3]
	b led1_done

noled1:
	str r9, [r3]
	mov r9, r9, lsl #1
	str r9, [r2]

led1_done:
	ldmfd sp!, {pc}



read_button_2:
	stmfd sp!, {lr}

	mov r9, #(1<<18)
	ldr r0, [r4]
	ands r0, r6, r0
	beq noled1

	str r9, [r2]
	mov r9, r9, lsl #1
	str r9, [r3]
	b led1_done

noled2:
	str r9, [r3]
	mov r9, r9, lsl #1
	str r9, [r2]

led2_done:
	ldmfd sp!, {pc}



read_button_3:
	stmfd sp!, {lr}

	mov r9, #(1<<20)
	ldr r0, [r4]
	ands r0, r7, r0
	beq noled1

	str r9, [r2]
	mov r9, r9, lsl #1
	str r9, [r3]
	b led1_done

noled3:
	str r9, [r3]
	mov r9, r9, lsl #1
	str r9, [r2]

led3_done:
	ldmfd sp!, {pc}



read_button_4:
	stmfd sp!, {lr}

	mov r9, #(1<<22)
	ldr r0, [r4]
	ands r0, r8, r0
	beq noled1

	str r9, [r2]
	mov r9, r9, lsl #1
	str r9, [r3]
	b led1_done

noled4:
	str r9, [r3]
	mov r9, r9, lsl #1
	str r9, [r2]

led4_done:
	ldmfd sp!, {pc}

.end
