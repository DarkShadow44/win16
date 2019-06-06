#include <windows.h>

void WinMainCRTStartup()
{
	MessageBox(NULL, "success", "Info", MB_OK);
	_asm {
		xor ax, ax
		int 1ah
		int 1ah
		int 1ah
	}
}
