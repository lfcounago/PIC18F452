
_main:

;LFC_P2A.c,1 :: 		void main(){
;LFC_P2A.c,3 :: 		unsigned short numeros[]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7C,0x07,0x7F,0x67};
	MOVLW       63
	MOVWF       main_numeros_L0+0 
	MOVLW       6
	MOVWF       main_numeros_L0+1 
	MOVLW       91
	MOVWF       main_numeros_L0+2 
	MOVLW       79
	MOVWF       main_numeros_L0+3 
	MOVLW       102
	MOVWF       main_numeros_L0+4 
	MOVLW       109
	MOVWF       main_numeros_L0+5 
	MOVLW       124
	MOVWF       main_numeros_L0+6 
	MOVLW       7
	MOVWF       main_numeros_L0+7 
	MOVLW       127
	MOVWF       main_numeros_L0+8 
	MOVLW       103
	MOVWF       main_numeros_L0+9 
;LFC_P2A.c,7 :: 		ADCON1 = 0x07; //configuración de los canales analógicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;LFC_P2A.c,9 :: 		TRISD = 0; //se declara RD0 como una salida digital
	CLRF        TRISD+0 
;LFC_P2A.c,10 :: 		PORTD = 0; //se pone el terminal RD0 a 0
	CLRF        PORTD+0 
;LFC_P2A.c,11 :: 		TRISA = 0; //se declara RA0 como una salida digital
	CLRF        TRISA+0 
;LFC_P2A.c,12 :: 		PORTA = 0; //se pone el terminal RA0 a 0
	CLRF        PORTA+0 
;LFC_P2A.c,14 :: 		while(1){ //bucle infinito{
L_main0:
;LFC_P2A.c,16 :: 		for(unid = 0; unid < 6; unid++){
	CLRF        R3 
	CLRF        R4 
L_main2:
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main14
	MOVLW       6
	SUBWF       R3, 0 
L__main14:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;LFC_P2A.c,18 :: 		for(dec = 0; dec < 10; dec++){
	CLRF        R1 
	CLRF        R2 
L_main5:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main15
	MOVLW       10
	SUBWF       R1, 0 
L__main15:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;LFC_P2A.c,20 :: 		for(cont = 0; cont < 25; cont++){
	CLRF        R5 
	CLRF        R6 
L_main8:
	MOVLW       128
	XORWF       R6, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVLW       25
	SUBWF       R5, 0 
L__main16:
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;LFC_P2A.c,21 :: 		PORTD = numeros[dec];
	MOVLW       main_numeros_L0+0
	ADDWF       R1, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_numeros_L0+0)
	ADDWFC      R2, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;LFC_P2A.c,22 :: 		PORTA.B0 = 1 ;
	BSF         PORTA+0, 0 
;LFC_P2A.c,23 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	NOP
	NOP
;LFC_P2A.c,24 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;LFC_P2A.c,26 :: 		PORTD = numeros[unid];
	MOVLW       main_numeros_L0+0
	ADDWF       R3, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_numeros_L0+0)
	ADDWFC      R4, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;LFC_P2A.c,27 :: 		PORTA.B1 = 1 ;
	BSF         PORTA+0, 1 
;LFC_P2A.c,28 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	NOP
	NOP
;LFC_P2A.c,29 :: 		PORTA.B1 = 0;
	BCF         PORTA+0, 1 
;LFC_P2A.c,20 :: 		for(cont = 0; cont < 25; cont++){
	INFSNZ      R5, 1 
	INCF        R6, 1 
;LFC_P2A.c,30 :: 		}
	GOTO        L_main8
L_main9:
;LFC_P2A.c,18 :: 		for(dec = 0; dec < 10; dec++){
	INFSNZ      R1, 1 
	INCF        R2, 1 
;LFC_P2A.c,32 :: 		}
	GOTO        L_main5
L_main6:
;LFC_P2A.c,16 :: 		for(unid = 0; unid < 6; unid++){
	INFSNZ      R3, 1 
	INCF        R4, 1 
;LFC_P2A.c,36 :: 		}
	GOTO        L_main2
L_main3:
;LFC_P2A.c,37 :: 		}
	GOTO        L_main0
;LFC_P2A.c,38 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
