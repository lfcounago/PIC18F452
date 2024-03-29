
_main:

;LFC_P3A.c,1 :: 		void main()
;LFC_P3A.c,4 :: 		unsigned short anterior = 1;
	MOVLW       1
	MOVWF       main_anterior_L0+0 
;LFC_P3A.c,5 :: 		ADCON1 = 0x07; //configuración de los canales anal?gicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P3A.c,7 :: 		TRISB.B2 = 1; //se declara B2 como una entrada digital
	BSF         TRISB+0, 2 
;LFC_P3A.c,8 :: 		TRISB.B3 = 0; //se declara B2 como una salida digital
	BCF         TRISB+0, 3 
;LFC_P3A.c,9 :: 		PORTB.B2 = 1;
	BSF         PORTB+0, 2 
;LFC_P3A.c,10 :: 		PORTB.B3 = 0;
	BCF         PORTB+0, 3 
;LFC_P3A.c,11 :: 		while(1)
L_main0:
;LFC_P3A.c,13 :: 		anterior = PORTB.B2;
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       main_anterior_L0+0 
;LFC_P3A.c,14 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;LFC_P3A.c,15 :: 		if((anterior == 1) && (PORTB.B2 == 0)){
	MOVF        main_anterior_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	BTFSC       PORTB+0, 2 
	GOTO        L_main5
L__main6:
;LFC_P3A.c,16 :: 		PORTB.B3 = !PORTB.B3;
	BTG         PORTB+0, 3 
;LFC_P3A.c,17 :: 		}
L_main5:
;LFC_P3A.c,18 :: 		}
	GOTO        L_main0
;LFC_P3A.c,19 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
