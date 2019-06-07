//#include <windows.h>

asm (
	"call  _dosmain\n"
     "mov   $0x4C,%ah\n"
     "int   $0x21\n"
);

static void print(char *string)
{
    asm volatile ("mov   $0x09, %%ah\n"
                  "int   $0x21\n"
                  : /* no output */
                  : "d"(string)
                  : "ah");
}

int dosmain(void)
{
    print("Hello, World2!\n$");
    return 0;
}

/*
void WinMainCRTStartup()
{
	// Windows doesn't run an exe < 376 byte in NE mode, but runs it as dos mdoe instead... Add a bit of "padding"...
	char *message = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
	//MessageBox(NULL, "success", "Info", MB_OK);
	_asm {
		xor ax, ax
		int 1ah
		int 1ah
		int 1ah
	}
}*/
