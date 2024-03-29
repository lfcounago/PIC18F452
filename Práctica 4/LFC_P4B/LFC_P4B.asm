
_interrupt:

;LFC_P4B.c,19 :: 		void interrupt(){
;LFC_P4B.c,21 :: 		if(INTCON.RBIF && INTCON.RBIE){
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt2
	BTFSS       INTCON+0, 3 
	GOTO        L_interrupt2
L__interrupt9:
;LFC_P4B.c,23 :: 		ByteToStr(pulsos/2,txt);
	MOVF        _pulsos+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVLW       _txt+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;LFC_P4B.c,24 :: 		Lcd_Out(1, 1, "Pulsos: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LFC_P4B+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LFC_P4B+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LFC_P4B.c,25 :: 		Lcd_Out_CP(txt);
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;LFC_P4B.c,26 :: 		x= PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;LFC_P4B.c,27 :: 		INTCON.RBIF=0;
	BCF         INTCON+0, 0 
;LFC_P4B.c,28 :: 		pulsos++;
	INCF        _pulsos+0, 1 
;LFC_P4B.c,29 :: 		}
L_interrupt2:
;LFC_P4B.c,30 :: 		}
L_end_interrupt:
L__interrupt12:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P4B.c,33 :: 		void main()
;LFC_P4B.c,36 :: 		ADCON1=0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P4B.c,38 :: 		TRISA.B4=1;
	BSF         TRISA+0, 4 
;LFC_P4B.c,39 :: 		TRISB.B4=1;
	BSF         TRISB+0, 4 
;LFC_P4B.c,41 :: 		INTCON2.RBPU = 0;
	BCF         INTCON2+0, 7 
;LFC_P4B.c,42 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;LFC_P4B.c,43 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;LFC_P4B.c,44 :: 		INTCON.RBIE = 0;
	BCF         INTCON+0, 3 
;LFC_P4B.c,45 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LFC_P4B.c,47 :: 		LCD_INIT();
	CALL        _Lcd_Init+0, 0
;LFC_P4B.c,50 :: 		while(1)
L_main3:
;LFC_P4B.c,52 :: 		if(PORTA.B4 && flanco)
	BTFSS       PORTA+0, 4 
	GOTO        L_main7
	MOVF        _flanco+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
L__main10:
;LFC_P4B.c,54 :: 		INTCON.RBIE=1;
	BSF         INTCON+0, 3 
;LFC_P4B.c,55 :: 		delay_ms(6000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;LFC_P4B.c,56 :: 		pulsos=0;
	CLRF        _pulsos+0 
;LFC_P4B.c,57 :: 		}
L_main7:
;LFC_P4B.c,58 :: 		INTCON.RBIE=0;
	BCF         INTCON+0, 3 
;LFC_P4B.c,59 :: 		flanco=PORTA.B4;
	MOVLW       0
	BTFSC       PORTA+0, 4 
	MOVLW       1
	MOVWF       _flanco+0 
;LFC_P4B.c,60 :: 		}
	GOTO        L_main3
;LFC_P4B.c,61 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
