/* SPDX-License-Identifier: GPL-2.0-only */

#include <memlayout.h>

/*
 * Start of available space is 0x15000 and this is where the
 * header for the user app (verstage) must be mapped.
 * Size is 0x28000 bytes
 */
#define PSP_SRAM_START			0x15000
#define PSP_SRAM_SIZE			160K

#define VERSTAGE_START			0x15000
#define VERSTAGE_SIZE			60K
#define VBOOT_WORK_START		VERSTAGE_START + VERSTAGE_SIZE
#define VBOOT_WORK_SIZE			12K
#define FMAP_CACHE_SIZE			2K

/*
 * The temp stack can be made much smaller if needed - even 256 bytes
 * should be sufficient.  This is just for the function mapping the
 * actual stack.
 */
#define PSP_VERSTAGE_TEMP_STACK_START	0x39000
#define PSP_VERSTAGE_TEMP_STACK_SIZE	4K

/*
 * The top of the stack must be 4k aligned, so set the bottom as 4k aligned
 * and make the size a multiple of 4k
 */
#define PSP_VERSTAGE_STACK_START	0x3B000
#define PSP_VERSTAGE_STACK_SIZE		8K

ENTRY(_psp_vs_start)
SECTIONS
{
	SRAM_START(PSP_SRAM_START)
	_verstage = .;

		.text : { *(PSP_HEADER_DATA) }
		.text : { *(.text._psp_vs_start) }
		.text : { *(.text.Main) }
		.text : { *(.text*) }
		.rodata : { *(.rodata*) }

		.data : { *(.data*) }
		.data : { *(PSP_FOOTER_DATA) }

		_bss_start = .;
		.bss : { *(.bss*) }
		_bss_end = .;

	_everstage = _verstage + VERSTAGE_SIZE;

	REGION(vboot2_work, VBOOT_WORK_START, VBOOT_WORK_SIZE, 64)

	FMAP_CACHE(., FMAP_SIZE)

	PSP_VERSTAGE_TEMP_STACK_END = (PSP_VERSTAGE_TEMP_STACK_START + PSP_VERSTAGE_TEMP_STACK_SIZE );

	REGION(stack, PSP_VERSTAGE_STACK_START, PSP_VERSTAGE_STACK_SIZE, 64)
	PSP_VERSTAGE_STACK_BASE = _stack;
	PSP_VERSTAGE_STACK_END = _estack;
	SRAM_END(PSP_SRAM_START + PSP_SRAM_SIZE)
}