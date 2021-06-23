/*
 * Aufgabe9_1.c
 *
 *  Created on: 16.10.2020
 *      Author: Daniel Seiler
 */

#include "LPC21XX.h"
#include <stdint.h>

#define LED_MASK	(0xff << 16)

uint16_t AdcRead(void) {
	ADCR |= (1 << 24);
	while (!(ADDR & (1 << 31)));
	return (ADDR & 0xFFC0) >> 6;
}

void AdcConfig(void) {
	PINSEL1 = (1 << 22);	//P0.27 <- AIN1
	ADCR = 0x210601;		//001000010000011000000001
}

void LedConfig(void) {
	IODIR1 = LED_MASK;
}

void UartConfig(void) {
	PINSEL0 = 0b0101;	//P=0.0 <- TxD; p=0.1 <- RxD (UART0)
	U0LCR = 0b10000011;	//8bit char length & enable divisor latch
	U0DLL = 120;		//DLL = 18 432 000 / (16 * 9200) = 120
	U0LCR = 0b00000011;	//Disable dlab
}

void UartSendChar(uint8_t sendChar) {
	while (!(U0LSR & (1 << 5)));	//Wait while U0THR not empty
	U0THR = sendChar;
}

uint8_t hexToAscii(uint8_t hex) {
	if (hex <= 0x9) {
		return hex + 0x30;
	} else {
		return hex + 0x37;
	}
}

void UartSendAdc(uint16_t value) {
	uint8_t val1 = hexToAscii((value / 0x100) % 0x10);
	uint8_t val2 = hexToAscii((value / 0x10) % 0x10);
	uint8_t val3 = hexToAscii(value % 0x10);
	UartSendChar(0x30);	//'0'
	UartSendChar(0x78);	//'x'
	UartSendChar(val1);
	UartSendChar(val2);
	UartSendChar(val3);
	UartSendChar(0x0A);	//'\n'
	UartSendChar(0x0D);	//'\r'
}

void LedDisplay(uint16_t value) {//distribute values somewhat even on all leds
	IOCLR1 = LED_MASK;
	IOSET1 = (1 << 16);
	if (value > 142) {
		IOSET1 = (1 << 17);
	}
	if (((ADDR & 0xFFC0) >> 6) > 284) {
		IOSET1 = (1 << 18);
	}
	if (((ADDR & 0xFFC0) >> 6) > 426) {
		IOSET1 = (1 << 19);
	}
	if (((ADDR & 0xFFC0) >> 6) > 568) {
		IOSET1 = (1 << 20);
	}
	if (((ADDR & 0xFFC0) >> 6) > 710) {
		IOSET1 = (1 << 21);
	}
	if (((ADDR & 0xFFC0) >> 6) > 852) {
		IOSET1 = (1 << 22);
	}
	if (((ADDR & 0xFFC0) >> 6) > 994) {
		IOSET1 = (1 << 23);
	}
}

int main() {
	AdcConfig();
	LedConfig();
	UartConfig();
	while (42) {
		uint16_t adcVal = AdcRead();
		LedDisplay(adcVal);
		UartSendAdc(adcVal);
	}
}
