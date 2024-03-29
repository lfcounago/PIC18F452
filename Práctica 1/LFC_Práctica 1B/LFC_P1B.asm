
_main:

;LFC_P1B.c,4 :: 		void main()
;LFC_P1B.c,9 :: 		ADCON1 = 0X07; // Configuraci�n de los canales anal�gicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P1B.c,12 :: 		TRISC = 0; // Se declaran los RC como salidas digital
	CLRF        TRISC+0 
;LFC_P1B.c,13 :: 		PORTC = 0; // Se ponen los terminales RC a 0
	CLRF        PORTC+0 
;LFC_P1B.c,15 :: 		while (1)
L_main0:
;LFC_P1B.c,17 :: 		for (i = 0; i < 9; i++)
	CLRF        R1 
	CLRF        R2 
L_main2:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVLW       9
	SUBWF       R1, 0 
L__main7:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;LFC_P1B.c,19 :: 		PORTC = x[i];
	MOVLW       _x+0
	ADDWF       R1, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_x+0)
	ADDWFC      R2, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;LFC_P1B.c,20 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
;LFC_P1B.c,17 :: 		for (i = 0; i < 9; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;LFC_P1B.c,23 :: 		}
	GOTO        L_main2
L_main3:
;LFC_P1B.c,24 :: 		}
	GOTO        L_main0
;LFC_P1B.c,25 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
