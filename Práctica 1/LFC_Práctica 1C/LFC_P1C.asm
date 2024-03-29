
_main:

;LFC_P1C.c,4 :: 		void main()
;LFC_P1C.c,9 :: 		ADCON1 = 0X07; // Configuraci?n de los canales anal?gicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P1C.c,12 :: 		TRISC = 0;    // Se declaran los RC como salidas digital
	CLRF        TRISC+0 
;LFC_P1C.c,13 :: 		PORTC = 0;    // Se ponen los terminales RC a 0
	CLRF        PORTC+0 
;LFC_P1C.c,14 :: 		TRISB.B5 = 1; // Se declara B5 como entrada digital
	BSF         TRISB+0, 5 
;LFC_P1C.c,15 :: 		PORTB.B5 = 0; // Se inicializa el puerto B5 a 0
	BCF         PORTB+0, 5 
;LFC_P1C.c,17 :: 		while (1)
L_main0:
;LFC_P1C.c,19 :: 		for (i = 0; i < 16 && PORTB.B5; i++)
	CLRF        R1 
	CLRF        R2 
L_main2:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVLW       16
	SUBWF       R1, 0 
L__main10:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
	BTFSS       PORTB+0, 5 
	GOTO        L_main3
L__main8:
;LFC_P1C.c,21 :: 		PORTC = x[i];
	MOVLW       _x+0
	ADDWF       R1, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_x+0)
	ADDWFC      R2, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;LFC_P1C.c,22 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
;LFC_P1C.c,19 :: 		for (i = 0; i < 16 && PORTB.B5; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;LFC_P1C.c,23 :: 		}
	GOTO        L_main2
L_main3:
;LFC_P1C.c,24 :: 		}
	GOTO        L_main0
;LFC_P1C.c,25 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
