/* Maybe windows needs time, not instant terminate? Or sleep, or maybe some other exit... */

#include <windows.h>
asm (
	/*"lcall $0x0,$0xffff\n"*/
	".byte 0x9a,0xff,0xff,0x00,0x00\n"
	"call  _dosmain\n"
	"call  _dosmain\n"

     "mov   $0x4C,%ah\n"
     "int   $0x21\n"
);

static PASCAL void print(char *string)
{
    asm volatile ("mov   $0x09, %%ah\n"
                  "int   $0x21\n"
                  : /* no output */
                  : "d"(string)
                  : "ah");
}

int dosmain(void)
{
	print("Hello_World_I_am_Alive!\n$");
	print("Hello_World_2_am_Alive!\n$");
	print("Hello_World_I_am_Alive!\n$");
	asm("int3");
    return 0;
}

/*
void WinMainCRTStartup()
{
	// Windows doesn't run an exe < 376 byte in NE mode, but runs it as dos mode instead... Add a bit of "padding"...
	char *message = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
	//MessageBox(NULL, "success", "Info", MB_OK);
	_asm {
		xor ax, ax
		int 1ah
		int 1ah
		int 1ah
	}
}*/
