/*
 * Aufgabe7.c
 *
 *  Created on: 16.10.2020
 *      Author: Daniel Seiler
 */

#include <stdint.h>

unsigned long fakultaet(int); // Hier sehen Sie, wie die Funktion aussieht.

int main() {
	unsigned long ergebnis;
	int zahl = 5;
	ergebnis = fakultaet(zahl);
	return 0;
}

unsigned long fakultaet(int wert) {
	unsigned long ergebnis = 1;
	if (wert > 1) {
		ergebnis = wert * fakultaet(wert - 1);
	}
	return ergebnis;
}

void IRQ_Routine   (void){while (1) ;}
void FIQ_Routine   (void){while (1) ;}
void SWI_Routine   (void){while (1) ;}
void UNDEF_Routine (void){while (1) ;}

/*
main:
	push    {r11, lr}
	add     r11, sp, #4
	sub     sp, sp, #8
	mov     r3, #5							unsigned int zahl = 5;
	str     r3, [r11, #-8]
	ldr     r0, [r11, #-8]
	bl      fakultaet						ergebnis = fakultaet(zahl);
	str     r0, [r11, #-12]
	mov     r3, #0							return 0;
	mov     r0, r3
	sub     sp, r11, #4
	pop     {r11, lr}
	bx      lr
fakultaet:
	push    {r11, lr}
	add     r11, sp, #4
	sub     sp, sp, #16
	str     r0, [r11, #-16]

	mov     r3, #1							unsigned int ergebnis = 1;
	str     r3, [r11, #-8]
	ldr     r3, [r11, #-16]
	cmp     r3, #1
	ble     0x400001e8 <fakultaet+68>

	ldr     r3, [r11, #-16]					ergebnis = (wert) * fakultaet(wert - 1)
	sub     r3, r3, #1
	mov     r0, r3
	bl      fakultaet
	mov     r2, r0
	ldr     r3, [r11, #-16]
	mul     r3, r2, r3
	str     r3, [r11, #-8]

	ldr     r3, [r11, #-8]					return ergebnis;
*/
