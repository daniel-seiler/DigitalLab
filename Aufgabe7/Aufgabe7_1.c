/*
 * Aufgabe7.c
 *
 *  Created on: 16.10.2020
 *      Author: Daniel Seiler
 */


#include "LPC21XX.h"
#include <stdint.h>

int main()
{
	unsigned int a = 0x12345678;
	unsigned int b = a & 0x00000F00;
	unsigned int c = a ^ 0xFFFFFFFF;
	unsigned int d = a | 0xFFFFFF0F;
}

void IRQ_Routine   (void){while (1) ;}
void FIQ_Routine   (void){while (1) ;}
void SWI_Routine   (void){while (1) ;}
void UNDEF_Routine (void){while (1) ;}
