
_interrupt:

;LFC_P5B.c,3 :: 		void interrupt()
;LFC_P5B.c,5 :: 		if(!q)
	MOVF        _q+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;LFC_P5B.c,7 :: 		if(!PORTA.B0)
	BTFSC       PORTA+0, 0 
	GOTO        L_interrupt1
;LFC_P5B.c,9 :: 		PORTA.B5=0;
	BCF         PORTA+0, 5 
;LFC_P5B.c,10 :: 		q=0;
	CLRF        _q+0 
;LFC_P5B.c,11 :: 		}else if (PORTA.B0)
	GOTO        L_interrupt2
L_interrupt1:
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt3
;LFC_P5B.c,13 :: 		PORTA.B5=0;
	BCF         PORTA+0, 5 
;LFC_P5B.c,14 :: 		q=1;
	MOVLW       1
	MOVWF       _q+0 
;LFC_P5B.c,15 :: 		}
L_interrupt3:
L_interrupt2:
;LFC_P5B.c,16 :: 		} else if(q)
	GOTO        L_interrupt4
L_interrupt0:
	MOVF        _q+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt5
;LFC_P5B.c,18 :: 		if(!PORTA.B0)
	BTFSC       PORTA+0, 0 
	GOTO        L_interrupt6
;LFC_P5B.c,20 :: 		PORTA.B5=1;
	BSF         PORTA+0, 5 
;LFC_P5B.c,21 :: 		q=2;
	MOVLW       2
	MOVWF       _q+0 
;LFC_P5B.c,22 :: 		}else if (PORTA.B0)
	GOTO        L_interrupt7
L_interrupt6:
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt8
;LFC_P5B.c,24 :: 		PORTA.B5=0;
	BCF         PORTA+0, 5 
;LFC_P5B.c,25 :: 		q=1;
	MOVLW       1
	MOVWF       _q+0 
;LFC_P5B.c,26 :: 		}
L_interrupt8:
L_interrupt7:
;LFC_P5B.c,27 :: 		} else if(q==2)
	GOTO        L_interrupt9
L_interrupt5:
	MOVF        _q+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;LFC_P5B.c,29 :: 		if(!PORTA.B0)
	BTFSC       PORTA+0, 0 
	GOTO        L_interrupt11
;LFC_P5B.c,31 :: 		PORTA.B5=1;
	BSF         PORTA+0, 5 
;LFC_P5B.c,32 :: 		q=2;
	MOVLW       2
	MOVWF       _q+0 
;LFC_P5B.c,33 :: 		}else if (PORTA.B0)
	GOTO        L_interrupt12
L_interrupt11:
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt13
;LFC_P5B.c,35 :: 		PORTA.B5=1;
	BSF         PORTA+0, 5 
;LFC_P5B.c,36 :: 		q=3;
	MOVLW       3
	MOVWF       _q+0 
;LFC_P5B.c,37 :: 		}
L_interrupt13:
L_interrupt12:
;LFC_P5B.c,38 :: 		} else if(q==3)
	GOTO        L_interrupt14
L_interrupt10:
	MOVF        _q+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;LFC_P5B.c,40 :: 		if(!PORTA.B0)
	BTFSC       PORTA+0, 0 
	GOTO        L_interrupt16
;LFC_P5B.c,42 :: 		PORTA.B5=0;
	BCF         PORTA+0, 5 
;LFC_P5B.c,43 :: 		q=0;
	CLRF        _q+0 
;LFC_P5B.c,44 :: 		}else if (PORTA.B0)
	GOTO        L_interrupt17
L_interrupt16:
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt18
;LFC_P5B.c,46 :: 		PORTA.B5=1;
	BSF         PORTA+0, 5 
;LFC_P5B.c,47 :: 		q=3;
	MOVLW       3
	MOVWF       _q+0 
;LFC_P5B.c,48 :: 		}
L_interrupt18:
L_interrupt17:
;LFC_P5B.c,49 :: 		}
L_interrupt15:
L_interrupt14:
L_interrupt9:
L_interrupt4:
;LFC_P5B.c,51 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;LFC_P5B.c,52 :: 		}
L_end_interrupt:
L__interrupt22:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P5B.c,54 :: 		void main()
;LFC_P5B.c,57 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P5B.c,59 :: 		TRISA.B0 = 1;
	BSF         TRISA+0, 0 
;LFC_P5B.c,60 :: 		TRISA.B5 = 0;
	BCF         TRISA+0, 5 
;LFC_P5B.c,62 :: 		PORTA.B5=0;
	BCF         PORTA+0, 5 
;LFC_P5B.c,63 :: 		q=0;
	CLRF        _q+0 
;LFC_P5B.c,65 :: 		T0CON = 0x81; //Prescaler = 4
	MOVLW       129
	MOVWF       T0CON+0 
;LFC_P5B.c,67 :: 		INTCON.TMR0IF = 0; // se pone el flag a 0
	BCF         INTCON+0, 2 
;LFC_P5B.c,68 :: 		INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0
	BSF         INTCON+0, 5 
;LFC_P5B.c,69 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;LFC_P5B.c,73 :: 		TMR0H = (15536 >> 8);
	MOVLW       60
	MOVWF       TMR0H+0 
;LFC_P5B.c,74 :: 		TMR0L = 15536;
	MOVLW       176
	MOVWF       TMR0L+0 
;LFC_P5B.c,76 :: 		while (1);
L_main19:
	GOTO        L_main19
;LFC_P5B.c,77 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
