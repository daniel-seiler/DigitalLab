/*
 * Aufgabe7.c
 *
 *  Created on: 16.10.2020
 *      Author: Daniel Seiler
 */


#include "LPC21XX.h"
#include <stdint.h>

#define LED_MASK	(0xff << 16)
#define LED_1		(1<<16)
#define LED_8		(1<<24)

void delay() {
	for (unsigned int delay = 0xA0000; delay != 0; --delay);
}

void ledLoop() {
	unsigned int currentLed = LED_1;
	while(42)
	{
		IOSET1 = currentLed;
		delay();
		IOCLR1 = currentLed;
		currentLed <<= 1;
		if (currentLed == LED_8) {
			currentLed = LED_1;
		}
	}
}

int main()
{
	IODIR1 = LED_MASK;
	ledLoop();
}

void IRQ_Routine   (void){while (1) ;}
void FIQ_Routine   (void){while (1) ;}
void SWI_Routine   (void){while (1) ;}
void UNDEF_Routine (void){while (1) ;}
