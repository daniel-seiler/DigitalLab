/* ****************************************************************************************************** */
/*   LPC-H212X-A.cmd				LINKER  SCRIPT                                  	                  */
/*                                                                                                        */
/*                                                                                                        */
/* ****************************************************************************************************** */

/* identify the Entry Point  */

ENTRY(_startup)

/* specify the LPC2129 memory areas  */

MEMORY 
{
	flash				: ORIGIN = 0x00000000, LENGTH = 256K	/* free FLASH EPROM area  */
	ram   				: ORIGIN = 0x40000000, LENGTH = 16K		/* free RAM area  */
}



/* define a global symbol _stack_end  */

_stack_end = 0x40001EDC;

/* now define the output sections  */

SECTIONS 
{
	/*.startup : { *(startupa) } >ram  	/*	 the startup code goes into FLASH */
	
	.text :								/* collect all sections that should go into FLASH after startup  */ 
	{
		*(startupa)
		*(.text)						/* all .text sections (code)  */
		*(.rodata)						/* all .rodata sections (constants, strings, etc.)  */
		*(.rodata*)						/* all .rodata* sections (constants, strings, etc.)  */
		*(.glue_7)						/* all .glue_7 sections  (no idea what these are) */
		*(.glue_7t)						/* all .glue_7t sections (no idea what these are) */
		_etext = .;						/* define a global symbol _etext just after the last code byte */
	} >ram  							/* put all the above into FLASH */
	

	

	.data :								/* collect all initialized .data sections that go into RAM  */ 
	{
		_data = .;						/* create a global symbol marking the start of the .data section  */
		*(.data)						/* all .data sections  */
		_edata = .;						/* define a global symbol marking the end of the .data section  */
	} >ram          					/* put all the above into RAM (but load the LMA copy into FLASH) */

	.bss :								/* collect all uninitialized .bss sections that go into RAM  */
	{
		_bss_start = .;					/* define a global symbol marking the start of the .bss section */
		*(.bss)							/* all .bss sections  */
	} >ram								/* put all the above in RAM (it will be cleared in the startup code */

	. = ALIGN(4);						/* advance location counter to the next 32-bit boundary */
	_bss_end = . ;						/* define a global symbol marking the end of the .bss section */
	
	_end = .;							/* define a global symbol marking the end of application RAM */
}	
