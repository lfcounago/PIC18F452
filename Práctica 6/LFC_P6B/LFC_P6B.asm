
_interrupt:

;LFC_P6B.c,19 :: 		void interrupt()
;LFC_P6B.c,21 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LFC_P6B.c,23 :: 		aux = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _aux+0 
	MOVLW       0
	MOVWF       _aux+1 
;LFC_P6B.c,24 :: 		aux = aux + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _aux+0, 0 
	ADDWF       R0, 1 
	MOVF        _aux+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
;LFC_P6B.c,25 :: 		alfa = aux * 0.004887585;
	CALL        _word2double+0, 0
	MOVLW       9
	MOVWF       R4 
	MOVLW       40
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _alfa+0 
	MOVF        R1, 0 
	MOVWF       _alfa+1 
	MOVF        R2, 0 
	MOVWF       _alfa+2 
	MOVF        R3, 0 
	MOVWF       _alfa+3 
;LFC_P6B.c,27 :: 		FloatToStr(alfa, txt);
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
;LFC_P6B.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LFC_P6B.c,29 :: 		LCD_out(1, 1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LFC_P6B.c,31 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_interrupt0:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt0
	DECFSZ      R12, 1, 1
	BRA         L_interrupt0
	DECFSZ      R11, 1, 1
	BRA         L_interrupt0
	NOP
	NOP
;LFC_P6B.c,33 :: 		ADCON0.B2 = 1;
	BSF         ADCON0+0, 2 
;LFC_P6B.c,34 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P6B.c,36 :: 		void main()
;LFC_P6B.c,38 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;LFC_P6B.c,40 :: 		ADCON1 = 0x89;
	MOVLW       137
	MOVWF       ADCON1+0 
;LFC_P6B.c,41 :: 		ADCON0 = 0x19;
	MOVLW       25
	MOVWF       ADCON0+0 
;LFC_P6B.c,43 :: 		LCD_init();
	CALL        _Lcd_Init+0, 0
;LFC_P6B.c,45 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LFC_P6B.c,46 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;LFC_P6B.c,48 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;LFC_P6B.c,49 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LFC_P6B.c,51 :: 		ADCON0.B2 = 1;
	BSF         ADCON0+0, 2 
;LFC_P6B.c,53 :: 		while(1);
L_main1:
	GOTO        L_main1
;LFC_P6B.c,54 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
