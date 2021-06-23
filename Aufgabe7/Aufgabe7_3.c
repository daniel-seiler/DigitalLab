/*
 * Aufgabe7.c
 *
 *  Created on: 16.10.2020
 *      Author: Daniel Seiler
 */

#include "LPC21XX.h"
#include <stdint.h>
#include <stdbool.h>

#define LED_MASK	(0xff << 16)
#define BUTTON_1 	(1<<10) // Button 1 mask 0x400
#define LED_1		(1<<16)
#define LED_8		(1<<24)

void delay() {
	for (unsigned int delay = 0xA0000; delay != 0; --delay);
}

bool checkButton(unsigned int buttonMask) {
	return buttonMask & IOPIN0;
}

unsigned int ledPattern1(unsigned int currentLed) {
	currentLed <<= 1;
	return (currentLed >= LED_8) ? LED_1 : currentLed;
}

unsigned int ledPattern2(unsigned int currentLed) {
	currentLed >>= 1;
	return (currentLed < LED_1) ? LED_8 : currentLed;
}

void ledLoop() {
	unsigned int currentLed = LED_1;
	while (42) {
		IOSET1 = currentLed;
		delay();
		IOCLR1 = currentLed;
		currentLed = checkButton(BUTTON_1)
				? ledPattern1(currentLed)
						: ledPattern2(currentLed);
	}
}

int main() {
	IODIR1 = LED_MASK;
	ledLoop();
}

void IRQ_Routine   (void){while (1) ;}
void FIQ_Routine   (void){while (1) ;}
void SWI_Routine   (void){while (1) ;}
void UNDEF_Routine (void){while (1) ;}
