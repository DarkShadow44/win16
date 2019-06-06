extern WinMainCRTStartup_ : near

public	wstart_
.code 
wstart_:
	call WinMainCRTStartup_
	; exit
 	mov ah, 04ch
	int 021h
	int 021h
end wstart_ 
