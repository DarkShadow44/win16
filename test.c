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

/*
int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
	MessageBox(NULL, "success", "Info", MB_OK);
	return 0;
}*/
