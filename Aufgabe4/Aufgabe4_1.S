 /*
 * Beispiel.S
 *
 *  Created on: 02.10.2020
 *      Author: Daniel Seiler
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */

.global _startup /* Specify global symbol */
_startup:

	ldr sp, =0x40001000
	mov r5, #1
	bl subroutine1

stop:
nop
bal stop

subroutine1:
	stmfd sp!, {r4-r12, lr}
	mov r5, #2
	bl subroutine2
	ldmfd sp!, {r4-r12, pc}

subroutine2:
	stmfd sp!, {r4-r12, lr}
	mov r5, #3
	ldmfd sp!, {r4-r12, pc}

.end

