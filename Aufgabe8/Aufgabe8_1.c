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
#define BUTTON_1 	(1<<10)
#define LED_1		(1<<16)
#define LED_8		(1<<24)

void NonVectoredIRQ (void)__attribute__((interrupt("IRQ")));
bool interruptFlag = false;

void timerDelay(unsigned int time) {
	T0TCR = 0b10;		//Reset & disable counter
	T0MR0 = time;		//Set delay in ms
	T0TCR = 1;			//Start timer
	while (T0TCR != 0);	//Wait until timer resets
}

void checkButton(unsigned int buttonMask) {
	interruptFlag = buttonMask & IOPIN0;
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
		timerDelay(100);
		IOCLR1 = currentLed;
		currentLed = interruptFlag
				? ledPattern1(currentLed)
						: ledPattern2(currentLed);
	}
}

void NonVectoredIRQ() {
	EXTINT = 2;			//Clear EINT1
	interruptFlag = !interruptFlag;
	VICVectAddr = 0;	//Reset
}

void setup() {
	EXTMODE = 0b10;			//EINT1 edge sensitive
	EXTPOLAR = 0;			//All EINT low-active/falling-edge
	PINSEL0 = (1<<29);		//P0.14 <- EINT1
	VICIntEnable = (1<<15);	//Bit15 = 1
	VICDefVectAddr = (unsigned) NonVectoredIRQ;

	T0PR = 18432;
	T0MCR = 0b110;
}

int main() {
	IODIR1 = LED_MASK;
	setup();
	ledLoop();
}
