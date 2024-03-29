
_tecla:

;tecla12int.h,24 :: 		unsigned char tecla() // Esta funcion devuelve el valor asociado a la tecla
;tecla12int.h,27 :: 		unsigned char columna=0, fila, aux1=0x10, aux2;
	CLRF        tecla_columna_L0+0 
	MOVLW       16
	MOVWF       tecla_aux1_L0+0 
	MOVLW       49
	MOVWF       tecla_teclado_L0+0 
	MOVLW       50
	MOVWF       tecla_teclado_L0+1 
	MOVLW       51
	MOVWF       tecla_teclado_L0+2 
	MOVLW       52
	MOVWF       tecla_teclado_L0+3 
	MOVLW       53
	MOVWF       tecla_teclado_L0+4 
	MOVLW       54
	MOVWF       tecla_teclado_L0+5 
	MOVLW       55
	MOVWF       tecla_teclado_L0+6 
	MOVLW       56
	MOVWF       tecla_teclado_L0+7 
	MOVLW       57
	MOVWF       tecla_teclado_L0+8 
	MOVLW       42
	MOVWF       tecla_teclado_L0+9 
	MOVLW       48
	MOVWF       tecla_teclado_L0+10 
	MOVLW       35
	MOVWF       tecla_teclado_L0+11 
;tecla12int.h,31 :: 		delay_ms(Debounce);// antes de empezar a escanear las filas y las columnas se
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_tecla0:
	DECFSZ      R13, 1, 1
	BRA         L_tecla0
	DECFSZ      R12, 1, 1
	BRA         L_tecla0
	NOP
;tecla12int.h,33 :: 		for(fila=0; fila<Rows; fila++) // escaneamos las filas para averiguar la fila
	CLRF        tecla_fila_L0+0 
L_tecla1:
	MOVLW       4
	SUBWF       tecla_fila_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_tecla2
;tecla12int.h,35 :: 		if((PORTB&aux1)==0x00) break; //en la fila de la tecla pulsada hay un 0 y en
	MOVF        tecla_aux1_L0+0, 0 
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_tecla4
	GOTO        L_tecla2
L_tecla4:
;tecla12int.h,36 :: 		aux1=(aux1<<1);                //las dem�s hay un 1.
	RLCF        tecla_aux1_L0+0, 1 
	BCF         tecla_aux1_L0+0, 0 
;tecla12int.h,33 :: 		for(fila=0; fila<Rows; fila++) // escaneamos las filas para averiguar la fila
	INCF        tecla_fila_L0+0, 1 
;tecla12int.h,37 :: 		}
	GOTO        L_tecla1
L_tecla2:
;tecla12int.h,39 :: 		PORTB=0x01; // valor del puerto B para escanear la primera columna (columna=0).
	MOVLW       1
	MOVWF       PORTB+0 
;tecla12int.h,41 :: 		while((PORTB&MASK)!=MASK)// se escanean las columnas hasta que se encuentra la
L_tecla5:
	MOVLW       240
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_tecla6
;tecla12int.h,43 :: 		PORTB=(PORTB<<1);       //caso, las filas estar�n todas a 1. Al escanear las
	MOVF        PORTB+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       PORTB+0 
;tecla12int.h,44 :: 		columna++;            //columnas se produce un flanco de subida en el terminal
	INCF        tecla_columna_L0+0, 1 
;tecla12int.h,45 :: 		}                      //correspondiente a la fila de la tecla pulsada, lo que
	GOTO        L_tecla5
L_tecla6:
;tecla12int.h,48 :: 		PORTB=0x00; //condiciones del PORTB de espera a que se pulse una nueva tecla
	CLRF        PORTB+0 
;tecla12int.h,50 :: 		do // esperamos a que se deje de pulsar la tecla para enviar su valor.
L_tecla7:
;tecla12int.h,51 :: 		{delay_ms(2);
	MOVLW       6
	MOVWF       R12, 0
	MOVLW       48
	MOVWF       R13, 0
L_tecla10:
	DECFSZ      R13, 1, 1
	BRA         L_tecla10
	DECFSZ      R12, 1, 1
	BRA         L_tecla10
	NOP
;tecla12int.h,52 :: 		}while((PORTB&0xF0)!=0xF0); //Al soltar la tecla, se produce un cambio de nivel
	MOVLW       240
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       240
	BTFSS       STATUS+0, 2 
	GOTO        L_tecla7
;tecla12int.h,56 :: 		aux2=teclado[fila][columna];//devuelve el valor ASCII de la tecla pulsada
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        tecla_fila_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       tecla_teclado_L0+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(tecla_teclado_L0+0)
	ADDWFC      R1, 1 
	MOVF        tecla_columna_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
;tecla12int.h,57 :: 		return aux2;
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;tecla12int.h,58 :: 		}
L_end_tecla:
	RETURN      0
; end of _tecla

_interrupt:

;LFC_P4A.c,22 :: 		void interrupt() // se ha pulsado una tecla
;LFC_P4A.c,24 :: 		key = tecla(); // en la variable key se guarda el valor ASCII de la tecla pulsada
	CALL        _tecla+0, 0
	MOVF        R0, 0 
	MOVWF       _key+0 
;LFC_P4A.c,25 :: 		Lcd_Chr(1, 1, key);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LFC_P4A.c,26 :: 		x = PORTB; // para poder borrar el bit RBIF (define x global)
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;LFC_P4A.c,27 :: 		INTCON.RBIF=0; // se borra el bit RBIF despu s de llamar a la funci n tecla()
	BCF         INTCON+0, 0 
;LFC_P4A.c,28 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt

_main:

;LFC_P4A.c,31 :: 		void main() {
;LFC_P4A.c,33 :: 		TRISB = 0xF0; // el nibble alto son entradas y el nibble bajo son salidas
	MOVLW       240
	MOVWF       TRISB+0 
;LFC_P4A.c,34 :: 		PORTB = 0;
	CLRF        PORTB+0 
;LFC_P4A.c,35 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;LFC_P4A.c,36 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;LFC_P4A.c,38 :: 		INTCON2.RBPU = 0; // se habilitan las resistencias de pullup del puerto B
	BCF         INTCON2+0, 7 
;LFC_P4A.c,39 :: 		x = PORTB; // para poder borrar el RBIF
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;LFC_P4A.c,40 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;LFC_P4A.c,41 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;LFC_P4A.c,42 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LFC_P4A.c,44 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;LFC_P4A.c,46 :: 		while(1);
L_main11:
	GOTO        L_main11
;LFC_P4A.c,48 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
