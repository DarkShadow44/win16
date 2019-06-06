#include <windows.h>

void WinMainCRTStartup()
{
	// Windows doesn't run an exe < 376 byte in NE mode, but runs it as dos mdoe instead... Add a bit of "padding"...
	char *message = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
	MessageBox(NULL, "success", "Info", MB_OK);
	_asm {
		xor ax, ax
		int 1ah
		int 1ah
		int 1ah
	}
}
