OUTPUT_FORMAT(binary)
SECTIONS
{
	alignment = 2;

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
		SHORT (184);
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
		SHORT (202);
		/* Segment number of automatic data segment */
		SHORT (2);
		/* Initial size of local heap */
		SHORT (0x400);
		/* Initial size of stack */
		SHORT (0x2000);
		/* Initial CS:IP */
		LONG (0x1001C); /* FIXME */
		/* initial SS:SP */
		LONG (0x20000);
		/* Number of entries in segment table */
		SHORT (2);
		/* Number of entries in module reference table */
		SHORT (1); /* FIXME */
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
		SHORT (ADDR(.imported_names_table) - ADDR(.ne_header) - 1);
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
		SHORT (SIZEOF(.segment1));
		/* Flags */
		SHORT (0xD40);
		/* Minimum allocation */
		SHORT (SIZEOF(.segment1));

		/* Position */
		SHORT (ADDR(.segment2)  >> alignment);
		/* Length */
		SHORT (SIZEOF(.segment2));
		/* Flags */
		SHORT (0xC41);
		/* Minimum allocation */
		SHORT (SIZEOF(.segment2));
	}

	.resource_table :
	{
		SHORT (0);
		SHORT (0);
	}

	.resident_name_table :
	{
		BYTE (4);
		BYTE (74);
		BYTE (65);
		BYTE (73);
		BYTE (74);
		SHORT (0);

		BYTE (0);
		SHORT (1);
	}

	.module_reference_table :
	{
		SHORT (1);
	}

	.imported_names_table :
	{
		BYTE (4);
		BYTE (0x55);
		BYTE (0x53);
		BYTE (0x45);
		BYTE (0x52);
	}

	.non_resident_name_table :
	{
		BYTE(8);
		BYTE(0x74); BYTE(0x65); BYTE(0x73); BYTE(0x74); BYTE(0x2e); BYTE(0x65); BYTE(0x78); BYTE(0x65);
		SHORT (0);

		BYTE (0);
		SHORT (0x5153);
	}

	.entry_table :
	{
		SHORT(0);
	}

    .segment1 ALIGN (1 << alignment):
    {
		BYTE (83);
		BYTE (81);
		BYTE (82);
		BYTE (49);
		BYTE (192);
		BYTE (80);
		BYTE (30);
		BYTE (184);
		BYTE (5);
		BYTE (0);
		BYTE (80);
		BYTE (30);
		BYTE (184);
		BYTE (0);
		BYTE (0);
		BYTE (80);
		BYTE (49);
		BYTE (192);
		BYTE (80);
		BYTE (154);
		BYTE (255);
		BYTE (255);
		BYTE (0);
		BYTE (0);
		BYTE (90);
		BYTE (89);
		BYTE (91);
		BYTE (195);
		BYTE (232);
		BYTE (225);
		BYTE (255);
		BYTE (180);
		BYTE (76);
		BYTE (205);
		BYTE (33);
		BYTE (205);
		BYTE (33);
    }

	.segment1_reloc :
	{
		SHORT (1);
		BYTE (3);
		BYTE (1);
		SHORT (20);
		SHORT (1);
		SHORT (1);
	}

	.segment2 ALIGN (1 << alignment) :
	{
		BYTE (73);
		BYTE (110);
		BYTE (102);
		BYTE (111);
		BYTE (0);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
		BYTE (120);
	}

	/DISCARD/ :
	{
		*(.text)
		*(*)
	}
}
