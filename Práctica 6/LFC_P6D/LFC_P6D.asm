
_interrupt:

;LFC_P6D.c,22 :: 		void interrupt()
;LFC_P6D.c,24 :: 		if (INTCON.INT0IF && INTCON.INT0IE)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt2
	BTFSS       INTCON+0, 4 
	GOTO        L_interrupt2
L__interrupt13:
;LFC_P6D.c,26 :: 		cont++;
	INCF        _cont+0, 1 
;LFC_P6D.c,28 :: 		if (cont > 2)
	MOVF        _cont+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt3
;LFC_P6D.c,30 :: 		cont = 0;
	CLRF        _cont+0 
;LFC_P6D.c,31 :: 		}
L_interrupt3:
;LFC_P6D.c,33 :: 		ADCON0.B2 = 1;
	BSF         ADCON0+0, 2 
;LFC_P6D.c,35 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;LFC_P6D.c,36 :: 		}
L_interrupt2:
;LFC_P6D.c,38 :: 		if (INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;LFC_P6D.c,40 :: 		TMR0H = (18661 >> 8);
	MOVLW       72
	MOVWF       TMR0H+0 
;LFC_P6D.c,41 :: 		TMR0L = 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;LFC_P6D.c,43 :: 		ADCON0.B2 = 1;
	BSF         ADCON0+0, 2 
;LFC_P6D.c,45 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;LFC_P6D.c,46 :: 		}
L_interrupt4:
;LFC_P6D.c,48 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt5
;LFC_P6D.c,50 :: 		aux = ADRESL + (ADRESH << 8);
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _aux+0 
;LFC_P6D.c,51 :: 		out = (4.88e-1) * aux;
	CALL        _byte2double+0, 0
	MOVLW       35
	MOVWF       R4 
	MOVLW       219
	MOVWF       R5 
	MOVLW       121
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       _out+0 
	MOVF        R1, 0 
	MOVWF       _out+1 
;LFC_P6D.c,53 :: 		if (cont == 0 )
	MOVF        _cont+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;LFC_P6D.c,55 :: 		let = 'C';
	MOVLW       67
	MOVWF       _let+0 
;LFC_P6D.c,56 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;LFC_P6D.c,57 :: 		else if (cont == 1)
	MOVF        _cont+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;LFC_P6D.c,59 :: 		out = out + 273, 15;
	MOVLW       17
	ADDWF       _out+0, 1 
	MOVLW       1
	ADDWFC      _out+1, 1 
;LFC_P6D.c,60 :: 		let = 'K';
	MOVLW       75
	MOVWF       _let+0 
;LFC_P6D.c,61 :: 		}
	GOTO        L_interrupt9
L_interrupt8:
;LFC_P6D.c,62 :: 		else if (cont == 2)
	MOVF        _cont+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;LFC_P6D.c,64 :: 		out = ((1) * out) + 32; // Al poner 1.8 da DemoLimit
	MOVLW       32
	ADDWF       _out+0, 1 
	MOVLW       0
	ADDWFC      _out+1, 1 
;LFC_P6D.c,65 :: 		let = 'F';
	MOVLW       70
	MOVWF       _let+0 
;LFC_P6D.c,66 :: 		}
L_interrupt10:
L_interrupt9:
L_interrupt7:
;LFC_P6D.c,68 :: 		LCD_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LFC_P6D.c,69 :: 		FloatToStr(out, txt);
	MOVF        _out+0, 0 
	MOVWF       R0 
	MOVF        _out+1, 0 
	MOVWF       R1 
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
;LFC_P6D.c,71 :: 		Lcd_out(1, 1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LFC_P6D.c,72 :: 		Lcd_Chr_cp(223);
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LFC_P6D.c,73 :: 		Lcd_Chr_cp(let);
	MOVF        _let+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LFC_P6D.c,75 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LFC_P6D.c,76 :: 		}
L_interrupt5:
;LFC_P6D.c,77 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P6D.c,78 :: 		void main()
;LFC_P6D.c,80 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;LFC_P6D.c,82 :: 		ADCON1 = 0x89;
	MOVLW       137
	MOVWF       ADCON1+0 
;LFC_P6D.c,83 :: 		ADCON0 = 0x99;
	MOVLW       153
	MOVWF       ADCON0+0 
;LFC_P6D.c,85 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;LFC_P6D.c,87 :: 		T0CON = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;LFC_P6D.c,88 :: 		TMR0H = (18661 >> 8);
	MOVLW       72
	MOVWF       TMR0H+0 
;LFC_P6D.c,89 :: 		TMR0L = 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;LFC_P6D.c,96 :: 		INTCON2.INTEDG0 = 1; // la interrupci�n la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 6 
;LFC_P6D.c,97 :: 		INTCON.INT0IF = 0;   // se pone el flag de la interrupci�n INT0 a 0
	BCF         INTCON+0, 1 
;LFC_P6D.c,98 :: 		INTCON.INT0IE = 1;   // se habilita la interrupci�n INT0
	BSF         INTCON+0, 4 
;LFC_P6D.c,99 :: 		INTCON2.RBPU = 0;
	BCF         INTCON2+0, 7 
;LFC_P6D.c,101 :: 		INTCON.TMR0IF = 0; // se pone el flaga 0
	BCF         INTCON+0, 2 
;LFC_P6D.c,102 :: 		INTCON.TMR0IE = 1; // se habilita la interrupci�n del Timer 0
	BSF         INTCON+0, 5 
;LFC_P6D.c,104 :: 		PIR1.ADIF = 0; // el bit PIR1.ADIF se pone a 1 siempre que el convertidor AD finaliza una conversi�n
	BCF         PIR1+0, 6 
;LFC_P6D.c,111 :: 		una conversion AD*/
	BSF         PIE1+0, 6 
;LFC_P6D.c,113 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;LFC_P6D.c,114 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;LFC_P6D.c,116 :: 		ADCON0.B2 = 1;
	BSF         ADCON0+0, 2 
;LFC_P6D.c,118 :: 		while (1)
L_main11:
;LFC_P6D.c,119 :: 		;
	GOTO        L_main11
;LFC_P6D.c,120 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
