
_interrupt:

;LFC_P3B.c,1 :: 		void interrupt(){
;LFC_P3B.c,3 :: 		INTCON3.INT2IF = 0; // se borra el flag de la interrupción INT2
	BCF         INTCON3+0, 1 
;LFC_P3B.c,4 :: 		PORTB.B3 = !PORTB.B3; //Se enciende o apaga el LED
	BTG         PORTB+0, 3 
;LFC_P3B.c,6 :: 		}
L_end_interrupt:
L__interrupt3:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P3B.c,8 :: 		void main() {
;LFC_P3B.c,10 :: 		ADCON1 = 0x07; //configuraci?n de los canales anal?gicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P3B.c,12 :: 		TRISB.B2 = 1; //se declara B2 como una entrada digital
	BSF         TRISB+0, 2 
;LFC_P3B.c,13 :: 		TRISB.B3 = 0; //se declara B3 como una salida digital
	BCF         TRISB+0, 3 
;LFC_P3B.c,14 :: 		PORTB.B2 = 1;
	BSF         PORTB+0, 2 
;LFC_P3B.c,15 :: 		PORTB.B3 = 0;
	BCF         PORTB+0, 3 
;LFC_P3B.c,17 :: 		INTCON2.INTEDG2 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 4 
;LFC_P3B.c,18 :: 		INTCON3.INT2IF = 0; // se pone el flag de la interrupción INT2 a 0
	BCF         INTCON3+0, 1 
;LFC_P3B.c,19 :: 		INTCON3.INT2IE = 1; // se habilita la interrupción INT2
	BSF         INTCON3+0, 4 
;LFC_P3B.c,20 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;LFC_P3B.c,21 :: 		while(1);
L_main0:
	GOTO        L_main0
;LFC_P3B.c,22 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
