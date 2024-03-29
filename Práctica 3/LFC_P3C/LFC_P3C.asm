
_interrupt:

;LFC_P3C.c,5 :: 		void interrupt()
;LFC_P3C.c,7 :: 		if(INTCON.INT0IF && INTCON.INT0IE){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt2
	BTFSS       INTCON+0, 4 
	GOTO        L_interrupt2
L__interrupt25:
;LFC_P3C.c,8 :: 		if(unidades==9 && decenas==9){
	MOVF        _unidades+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
	MOVF        _decenas+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
L__interrupt24:
;LFC_P3C.c,9 :: 		unidades=0;
	CLRF        _unidades+0 
;LFC_P3C.c,10 :: 		decenas=0;
	CLRF        _decenas+0 
;LFC_P3C.c,11 :: 		} else if(unidades==9){
	GOTO        L_interrupt6
L_interrupt5:
	MOVF        _unidades+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;LFC_P3C.c,12 :: 		decenas++;
	INCF        _decenas+0, 1 
;LFC_P3C.c,13 :: 		unidades=0;
	CLRF        _unidades+0 
;LFC_P3C.c,14 :: 		}else{
	GOTO        L_interrupt8
L_interrupt7:
;LFC_P3C.c,15 :: 		unidades++;
	INCF        _unidades+0, 1 
;LFC_P3C.c,16 :: 		}
L_interrupt8:
L_interrupt6:
;LFC_P3C.c,17 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;LFC_P3C.c,18 :: 		}
L_interrupt2:
;LFC_P3C.c,21 :: 		if(INTCON3.INT1IF==1 && INTCON3.INT1IE==1){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt11
	BTFSS       INTCON3+0, 3 
	GOTO        L_interrupt11
L__interrupt23:
;LFC_P3C.c,22 :: 		if(unidades==0 && decenas==0){
	MOVF        _unidades+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt14
	MOVF        _decenas+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt14
L__interrupt22:
;LFC_P3C.c,23 :: 		unidades=9;
	MOVLW       9
	MOVWF       _unidades+0 
;LFC_P3C.c,24 :: 		decenas=9;
	MOVLW       9
	MOVWF       _decenas+0 
;LFC_P3C.c,25 :: 		}else if(unidades==0){
	GOTO        L_interrupt15
L_interrupt14:
	MOVF        _unidades+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt16
;LFC_P3C.c,26 :: 		unidades=9;
	MOVLW       9
	MOVWF       _unidades+0 
;LFC_P3C.c,27 :: 		decenas--;
	DECF        _decenas+0, 1 
;LFC_P3C.c,28 :: 		}else{
	GOTO        L_interrupt17
L_interrupt16:
;LFC_P3C.c,29 :: 		unidades--;
	DECF        _unidades+0, 1 
;LFC_P3C.c,30 :: 		}
L_interrupt17:
L_interrupt15:
;LFC_P3C.c,31 :: 		INTCON3.INT1IF=0;
	BCF         INTCON3+0, 0 
;LFC_P3C.c,32 :: 		}
L_interrupt11:
;LFC_P3C.c,34 :: 		}
L_end_interrupt:
L__interrupt27:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P3C.c,35 :: 		void main()
;LFC_P3C.c,37 :: 		TRISD = 0; // se configura el puerto D como salida
	CLRF        TRISD+0 
;LFC_P3C.c,38 :: 		TRISE = 0; // se configura el puerto E como salida
	CLRF        TRISE+0 
;LFC_P3C.c,40 :: 		PORTD = 0; // se pone el puerto D en 0
	CLRF        PORTD+0 
;LFC_P3C.c,41 :: 		PORTE = 0; // se pone el puerto E en 0
	CLRF        PORTE+0 
;LFC_P3C.c,44 :: 		TRISB.B0 = 1;        // se configura RB0 como entrada
	BSF         TRISB+0, 0 
;LFC_P3C.c,45 :: 		INTCON2.INTEDG0 = 1; // la interrupciï¿½n la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 6 
;LFC_P3C.c,46 :: 		INTCON.INT0IF = 0;   // se pone el flag de la interrupciï¿½n INT0 a 0
	BCF         INTCON+0, 1 
;LFC_P3C.c,47 :: 		INTCON.INT0IE = 1;   // se habilita la interrupciï¿½n INT0
	BSF         INTCON+0, 4 
;LFC_P3C.c,50 :: 		TRISB.B1 = 1;        // se configura RB1 como entrada
	BSF         TRISB+0, 1 
;LFC_P3C.c,51 :: 		INTCON2.INTEDG1 = 1; // la interrupciï¿½n la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 5 
;LFC_P3C.c,52 :: 		INTCON3.INT1IF = 0;  // se pone el flag de la interrupciï¿½n INT1 a 0
	BCF         INTCON3+0, 0 
;LFC_P3C.c,53 :: 		INTCON3.INT1IE = 1;  // se habilita la interrupciï¿½n INT1
	BSF         INTCON3+0, 3 
;LFC_P3C.c,56 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LFC_P3C.c,58 :: 		while (1)
L_main18:
;LFC_P3C.c,60 :: 		PORTD = numeros[decenas];
	MOVLW       _numeros+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_numeros+0)
	MOVWF       FSR0L+1 
	MOVF        _decenas+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;LFC_P3C.c,61 :: 		PORTE.B0 = 0;
	BCF         PORTE+0, 0 
;LFC_P3C.c,62 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main20:
	DECFSZ      R13, 1, 1
	BRA         L_main20
	DECFSZ      R12, 1, 1
	BRA         L_main20
	NOP
	NOP
;LFC_P3C.c,63 :: 		PORTE.B0 = 1;
	BSF         PORTE+0, 0 
;LFC_P3C.c,64 :: 		PORTD = numeros[unidades];
	MOVLW       _numeros+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_numeros+0)
	MOVWF       FSR0L+1 
	MOVF        _unidades+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;LFC_P3C.c,65 :: 		PORTE.B1 = 0;
	BCF         PORTE+0, 1 
;LFC_P3C.c,66 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main21:
	DECFSZ      R13, 1, 1
	BRA         L_main21
	DECFSZ      R12, 1, 1
	BRA         L_main21
	NOP
	NOP
;LFC_P3C.c,67 :: 		PORTE.B1 = 1;
	BSF         PORTE+0, 1 
;LFC_P3C.c,68 :: 		}
	GOTO        L_main18
;LFC_P3C.c,69 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
