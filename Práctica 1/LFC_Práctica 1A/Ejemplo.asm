
_main:

;Ejemplo.c,10 :: 		void main()
;Ejemplo.c,14 :: 		ADCON1 = 0x07; //configuración de los canales analógicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;Ejemplo.c,17 :: 		TRISC.B0 = 0; //se declara RC0 como una salida digital
	BCF         TRISC+0, 0 
;Ejemplo.c,18 :: 		PORTC.B0 = 0; //se pone el terminal RC0 a 0
	BCF         PORTC+0, 0 
;Ejemplo.c,24 :: 		while(1) //bucle infinito
L_main0:
;Ejemplo.c,26 :: 		PORTC.B0 = 1; //se pone el terminal RC0 a 1
	BSF         PORTC+0, 0 
;Ejemplo.c,27 :: 		delay_ms(600); //se introduce un retardo de 200ms en la ejecución del código
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;Ejemplo.c,28 :: 		PORTC.B0 = 0; //se pone el terminal RC0 a 0
	BCF         PORTC+0, 0 
;Ejemplo.c,29 :: 		delay_ms(400); //se introduce un retardo de 200ms en la ejecución del código
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
;Ejemplo.c,30 :: 		}
	GOTO        L_main0
;Ejemplo.c,31 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
