/*
 *Aufgabe 6.1
 *
 *  Created on: 15.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */


.equ PINSEL0, 0xE002C000

.equ USART_0_TXD_FUNCTION,	0x01
.equ USART_0_RXD_FUNCTION,	(0x01 << 2)

.equ U0RBR, 0xE000C000
.equ U0LCR, 0x0C
.equ U0LSR, 0x14

.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:

	ldr sp, =0x40001000
	bl uart_setup

send:
	ldr r5, =U0RBR
	ldr r0, =69				//"E"
check:
	ldr r6, [r5, #U0LSR]
	tst r6, #0b00100000
	beq check
	strb r0, [r5]
	b send

stop:
nop
bal stop

uart_setup:
	stmfd sp!, {r5, r6, lr}

	ldr r5, =PINSEL0
	ldr r6, [r5]
	bic r6, #0b1111
	orr r6, #0b0101
	str r6, [r5]

	ldr r5, =U0RBR
	ldr r6, =0b10000011		//DLAB = 1
	strb r6, [r5, #U0LCR]

	ldr r6, =120			//DLL = 18 432 000 / (16 * 9200) = 120
	strb r6, [r5]

	ldr r6, =0b00000011		//DLAB = 0
	strb r6, [r5, #U0LCR]

	ldmfd sp!, {r5, r6, pc}

.end

