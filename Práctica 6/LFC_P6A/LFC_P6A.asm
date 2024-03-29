
_interrupt:

;LFC_P6A.c,22 :: 		void interrupt()
;LFC_P6A.c,24 :: 		if(primera == 0)
	MOVLW       0
	XORWF       _primera+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt6
	MOVLW       0
	XORWF       _primera+0, 0 
L__interrupt6:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;LFC_P6A.c,26 :: 		primera++;
	INFSNZ      _primera+0, 1 
	INCF        _primera+1, 1 
;LFC_P6A.c,27 :: 		Lcd_Out(1,1, "Tiempo: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LFC_P6A+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LFC_P6A+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LFC_P6A.c,28 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;LFC_P6A.c,29 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;LFC_P6A.c,30 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;LFC_P6A.c,31 :: 		} else
	GOTO        L_interrupt1
L_interrupt0:
;LFC_P6A.c,33 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;LFC_P6A.c,34 :: 		lectura = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _lectura+0 
	MOVLW       0
	MOVWF       _lectura+1 
;LFC_P6A.c,35 :: 		lectura = lectura + (TMR0H << 8);
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _lectura+0, 0 
	ADDWF       R0, 1 
	MOVF        _lectura+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _lectura+0 
	MOVF        R1, 0 
	MOVWF       _lectura+1 
;LFC_P6A.c,36 :: 		lectura = (lectura * 0.000128);
	CALL        _word2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       114
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       _lectura+0 
	MOVF        R1, 0 
	MOVWF       _lectura+1 
;LFC_P6A.c,37 :: 		FloatToStr(lectura, txt);
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;LFC_P6A.c,38 :: 		Lcd_Out(2,1,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LFC_P6A.c,39 :: 		}
L_interrupt1:
;LFC_P6A.c,41 :: 		x = PORTB; // hay que leer el puerto B antes de borrar el flag
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;LFC_P6A.c,42 :: 		INTCON.RBIF = 0; // se borra el flag
	BCF         INTCON+0, 0 
;LFC_P6A.c,43 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P6A.c,45 :: 		void main()
;LFC_P6A.c,47 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P6A.c,49 :: 		TRISB.B4 = 1;
	BSF         TRISB+0, 4 
;LFC_P6A.c,51 :: 		T0CON = 0x07;
	MOVLW       7
	MOVWF       T0CON+0 
;LFC_P6A.c,52 :: 		INTCON.TMR0IF = 0; // se pone el flag a 0
	BCF         INTCON+0, 2 
;LFC_P6A.c,53 :: 		INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0
	BSF         INTCON+0, 5 
;LFC_P6A.c,55 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;LFC_P6A.c,56 :: 		INTCON.RBIF = 0; // se pone el flag a 0
	BCF         INTCON+0, 0 
;LFC_P6A.c,57 :: 		INTCON.RBIE = 1; // se habilita la interrupción por cambio de nivel
	BSF         INTCON+0, 3 
;LFC_P6A.c,58 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;LFC_P6A.c,60 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;LFC_P6A.c,62 :: 		while(1);
L_main2:
	GOTO        L_main2
;LFC_P6A.c,64 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
