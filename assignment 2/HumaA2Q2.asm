         ORG 00h
HERE:    SETB P2.1     ;set PORtB
         LCALL Delay   ; call delay subroutine
	 CLR P2.1     ;clear PORtB
         LCALL Delay   ; call delay subroutine
         SJMP HERE     ; loop continously
		 
		 ORG 300H
Delay:
        MOV R3,#54      ; put 55 to R3
again:	DJNZ R3,again   ; wait here 
		RET             ; return after 10us
		END
