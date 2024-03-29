
_interrupt:

;LFC_P5C.c,2 :: 		void interrupt()
;LFC_P5C.c,4 :: 		if((INTCON3.INT1IF)&&(INTCON3.INT1IE))
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt2
	BTFSS       INTCON3+0, 3 
	GOTO        L_interrupt2
L__interrupt11:
;LFC_P5C.c,6 :: 		PORTC.B0=1;
	BSF         PORTC+0, 0 
;LFC_P5C.c,7 :: 		T0CON=0x87;
	MOVLW       135
	MOVWF       T0CON+0 
;LFC_P5C.c,8 :: 		TMR0H=(18661>>8);
	MOVLW       72
	MOVWF       TMR0H+0 
;LFC_P5C.c,9 :: 		TMR0L=18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;LFC_P5C.c,10 :: 		INTCON3.INT1IF=0;
	BCF         INTCON3+0, 0 
;LFC_P5C.c,11 :: 		INTCON3.INT1IE=0;
	BCF         INTCON3+0, 3 
;LFC_P5C.c,12 :: 		}
L_interrupt2:
;LFC_P5C.c,13 :: 		if((INTCON.TMR0IF)&&(INTCON.TMR0IE))
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt5
	BTFSS       INTCON+0, 5 
	GOTO        L_interrupt5
L__interrupt10:
;LFC_P5C.c,15 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;LFC_P5C.c,16 :: 		i++;
	INCF        _i+0, 1 
;LFC_P5C.c,17 :: 		if(i<2){
	MOVLW       2
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt6
;LFC_P5C.c,18 :: 		TMR0H=(18661>>8);
	MOVLW       72
	MOVWF       TMR0H+0 
;LFC_P5C.c,19 :: 		TMR0L=18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;LFC_P5C.c,20 :: 		}else{
	GOTO        L_interrupt7
L_interrupt6:
;LFC_P5C.c,21 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;LFC_P5C.c,22 :: 		T0CON=0;
	CLRF        T0CON+0 
;LFC_P5C.c,23 :: 		INTCON3.INT1IF=0;
	BCF         INTCON3+0, 0 
;LFC_P5C.c,24 :: 		INTCON3.INT1IE=1;
	BSF         INTCON3+0, 3 
;LFC_P5C.c,25 :: 		i=0;
	CLRF        _i+0 
;LFC_P5C.c,26 :: 		}
L_interrupt7:
;LFC_P5C.c,27 :: 		}
L_interrupt5:
;LFC_P5C.c,28 :: 		}
L_end_interrupt:
L__interrupt13:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P5C.c,30 :: 		void main() {
;LFC_P5C.c,31 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;LFC_P5C.c,32 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;LFC_P5C.c,33 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;LFC_P5C.c,35 :: 		INTCON2.INTEDG1 = 1;
	BSF         INTCON2+0, 5 
;LFC_P5C.c,36 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;LFC_P5C.c,37 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;LFC_P5C.c,39 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;LFC_P5C.c,40 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;LFC_P5C.c,42 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LFC_P5C.c,44 :: 		while(1);
L_main8:
	GOTO        L_main8
;LFC_P5C.c,45 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
