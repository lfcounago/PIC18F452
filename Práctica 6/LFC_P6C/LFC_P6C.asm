
_interrupt:

;LFC_P6C.c,22 :: 		void interrupt()
;LFC_P6C.c,24 :: 		if (INTCON.TMR0IF) // Comprueba el flag de interrupci�n del timer est� ejecutada(Por eso se iguala a 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;LFC_P6C.c,26 :: 		INTCON.TMR0IF = 0;    // Deshabilita el flag interrupci�n
	BCF         INTCON+0, 2 
;LFC_P6C.c,27 :: 		TMR0H = (18661 >> 8); // Parte alta
	MOVLW       72
	MOVWF       TMR0H+0 
;LFC_P6C.c,28 :: 		TMR0L = 18661;        // Parte baja
	MOVLW       229
	MOVWF       TMR0L+0 
;LFC_P6C.c,29 :: 		ADCON0.B2 = 1;        // Activa conversi�n(de anal�gico a digital)
	BSF         ADCON0+0, 2 
;LFC_P6C.c,30 :: 		PORTC.B0 = !PORTC.B0;
	BTG         PORTC+0, 0 
;LFC_P6C.c,31 :: 		}
L_interrupt0:
;LFC_P6C.c,32 :: 		if (PIR1.ADIF) // Si finaliza la conversi�n
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;LFC_P6C.c,34 :: 		PIR1.ADIF = 0; // Pones la conversi�n sin finalizar
	BCF         PIR1+0, 6 
;LFC_P6C.c,36 :: 		aux = ADRESL;              // Resultado del AD
	MOVF        ADRESL+0, 0 
	MOVWF       _aux+0 
	MOVLW       0
	MOVWF       _aux+1 
;LFC_P6C.c,37 :: 		aux = aux + (ADRESH << 8); // Resultado del AD
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
;LFC_P6C.c,38 :: 		alfa = aux * 0.48875855;   // T=100*Vout
	CALL        _word2double+0, 0
	MOVLW       144
	MOVWF       R4 
	MOVLW       62
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
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
;LFC_P6C.c,40 :: 		floatToStr(alfa, txt); // Convertir para que se muestre en LCD
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
;LFC_P6C.c,41 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LFC_P6C.c,42 :: 		LCD_out(1, 1, txt); // Lo muestra
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LFC_P6C.c,43 :: 		}
L_interrupt1:
;LFC_P6C.c,44 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P6C.c,45 :: 		void main()
;LFC_P6C.c,47 :: 		TRISE.B0 = 1; // Se activa como entrada el bit 0 del E
	BSF         TRISE+0, 0 
;LFC_P6C.c,49 :: 		ADCON1 = 0x89; // Registro ADCON
	MOVLW       137
	MOVWF       ADCON1+0 
;LFC_P6C.c,50 :: 		ADCON0 = 0x99; // Registro ADCON
	MOVLW       153
	MOVWF       ADCON0+0 
;LFC_P6C.c,52 :: 		LCD_init(); // Inicia el LCD
	CALL        _Lcd_Init+0, 0
;LFC_P6C.c,54 :: 		T0CON = 0x85;         // Configurar timer0
	MOVLW       133
	MOVWF       T0CON+0 
;LFC_P6C.c,55 :: 		TMR0H = (18661 >> 8); // Parte alta
	MOVLW       72
	MOVWF       TMR0H+0 
;LFC_P6C.c,56 :: 		TMR0L = 18661;        // Parte baja
	MOVLW       229
	MOVWF       TMR0L+0 
;LFC_P6C.c,58 :: 		INTCON.TMR0IF = 0; // Deshabilita el flag interrupci�n
	BCF         INTCON+0, 2 
;LFC_P6C.c,59 :: 		INTCON.TMR0IE = 1; // Habilita la interrupci�n.
	BSF         INTCON+0, 5 
;LFC_P6C.c,61 :: 		PIR1.ADIF = 0; // Deshabilito el flag de la conversi�n
	BCF         PIR1+0, 6 
;LFC_P6C.c,62 :: 		PIE1.ADIE = 1; // Habilito la conversi�n
	BSF         PIE1+0, 6 
;LFC_P6C.c,64 :: 		INTCON.PEIE = 1; // Es de tipo core
	BSF         INTCON+0, 6 
;LFC_P6C.c,65 :: 		INTCON.GIE = 1;  // Se habilita las interrupciones
	BSF         INTCON+0, 7 
;LFC_P6C.c,67 :: 		ADCON0.B2 = 1; // Activa conversi�n(de anal�gico a digital)
	BSF         ADCON0+0, 2 
;LFC_P6C.c,69 :: 		while (1);
L_main2:
	GOTO        L_main2
;LFC_P6C.c,70 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
