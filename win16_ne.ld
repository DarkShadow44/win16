OUTPUT_FORMAT(binary)
SECTIONS
{
	alignment = 1;

	.dos_header :
	{
		/* Magic */
		SHORT (0x5A4D)
		/* Used bytes on the last page (every page is 512 bytes) */
		SHORT (128);
		/* Number of pages */
		SHORT (1);
		/* Relocations */
		SHORT (0);
		/* Size of the header in paragraphs (every paragrpah is 16 bytes) */
		SHORT (4);
		/* Minimum extra paragraphs needed */
		SHORT (0);
		/* Maximum number of extra paragraphs */
		SHORT (0xFFFF);
		/* Initial (relative) SS value */
		SHORT (0);
		/* Initial SP value */
		SHORT (0);
		/* Checksum */
		SHORT (0);
		/* Initial IP value */
		SHORT (0);
		/* Initial (relative) CS value */
		SHORT (0);
		/* Address of relocation table */
		SHORT(0x40);
		/* Overlay number */
		SHORT (0);
		/* Reserved */
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		/* OEM identifier */
		SHORT (0);
		/* OEM information */
		SHORT (0);
		/* Reserved */
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		/* Offset NE header */
		SHORT (0x80);
	}
	.= 0x80;
	.ne_header :
	{
		/* Magic */
		SHORT (0x454E);
		/* Linker major version */
		BYTE (1);
		/* Linker minor version */
		BYTE (1);
		/* Offset Entry Table */
		SHORT (ADDR(.entry_table) - ADDR(.ne_header));
		/* Length of entry table */
		SHORT (SIZEOF(.entry_table));
		/* Checksum */
		LONG (0);
		/* Flags */
		SHORT (0);
		/* Segment number of automatic data segment */
		SHORT (0);
		/* Initial size of local heap */
		SHORT (0x400);
		/* Initial size of stack */
		SHORT (0x2000);
		/* Initial CS:IP */
		LONG (0); /* FIXME */
		/* initial SS:SP */
		LONG (20000);
		/* Number of entries in segment table */
		SHORT (1);
		/* Number of entries in module reference table */
		SHORT (0); /* FIXME */
		/* Length of non resident name table */
		SHORT (SIZEOF(.non_resident_name_table));
		/* Offset segment table */
		SHORT (ADDR(.segment_table) - ADDR(.ne_header));
		/* Offset resource table */
		SHORT (ADDR(.resource_table) - ADDR(.ne_header));
		/* Offset resident name table */
		SHORT (ADDR(.resident_name_table) - ADDR(.ne_header));
		/* Offset module reference table */
		SHORT (ADDR(.module_reference_table) - ADDR(.ne_header));
		/* Offset imported names table */
		SHORT (ADDR(.imported_names_table) - ADDR(.ne_header));
		/* Offset non resident name table */
		LONG (ADDR(.non_resident_name_table));
		/* Number of movable entries in entry table */
		SHORT (0);
		/* Logical sector alignment shift count */
		SHORT (alignment);
		/* Number of resource segments */
		SHORT (0);
		/* Flags for target OS */
		BYTE (2);
		/* Reserved */
		BYTE (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
		SHORT (0);
	}

	.segment_table :
	{
		/* Position */
		SHORT (ADDR(.segment1) >> alignment);
		/* Length */
		SHORT (SIZEOF(.segment1) >> alignment);
		/* Flags */
		SHORT (0);
		/* Minimum allocation */
		SHORT (SIZEOF(.segment1) >> alignment);
	}

	.resource_table :
	{
		SHORT (0);
		SHORT (0);
	}

	.resident_name_table :
	{
		LONG (0);
	}

	.module_reference_table :
	{

	}

	.imported_names_table :
	{

	}

	.non_resident_name_table :
	{

	}

	.entry_table :
	{
		LONG (0);
		LONG (0);
	}

    .segment1 :
    {
        *(.text);
    }
}
