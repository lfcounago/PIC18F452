
_DisplayDigit:

;LFC_P2B.c,5 :: 		void DisplayDigit(unsigned short digit)
;LFC_P2B.c,8 :: 		PORTC = SEGMENT_MAP[digit];
	MOVLW       _SEGMENT_MAP+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_SEGMENT_MAP+0)
	MOVWF       FSR0L+1 
	MOVF        FARG_DisplayDigit_digit+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;LFC_P2B.c,9 :: 		}
L_end_DisplayDigit:
	RETURN      0
; end of _DisplayDigit

_BinaryToDecimal:

;LFC_P2B.c,12 :: 		unsigned short BinaryToDecimal(unsigned short binary)
;LFC_P2B.c,14 :: 		unsigned short decimal = 0;
	CLRF        BinaryToDecimal_decimal_L0+0 
	MOVLW       1
	MOVWF       BinaryToDecimal_base_L0+0 
;LFC_P2B.c,18 :: 		while (binary)
L_BinaryToDecimal0:
	MOVF        FARG_BinaryToDecimal_binary+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_BinaryToDecimal1
;LFC_P2B.c,21 :: 		decimal += (binary % 10) * base;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_BinaryToDecimal_binary+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MULWF       BinaryToDecimal_base_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       BinaryToDecimal_decimal_L0+0, 1 
;LFC_P2B.c,23 :: 		binary /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_BinaryToDecimal_binary+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BinaryToDecimal_binary+0 
;LFC_P2B.c,25 :: 		base *= 2;
	RLCF        BinaryToDecimal_base_L0+0, 1 
	BCF         BinaryToDecimal_base_L0+0, 0 
;LFC_P2B.c,26 :: 		}
	GOTO        L_BinaryToDecimal0
L_BinaryToDecimal1:
;LFC_P2B.c,29 :: 		return decimal;
	MOVF        BinaryToDecimal_decimal_L0+0, 0 
	MOVWF       R0 
;LFC_P2B.c,30 :: 		}
L_end_BinaryToDecimal:
	RETURN      0
; end of _BinaryToDecimal

_main:

;LFC_P2B.c,32 :: 		void main()
;LFC_P2B.c,35 :: 		TRISC = 0;
	CLRF        TRISC+0 
;LFC_P2B.c,37 :: 		TRISB = 1;
	MOVLW       1
	MOVWF       TRISB+0 
;LFC_P2B.c,39 :: 		TRISD = 0;
	CLRF        TRISD+0 
;LFC_P2B.c,42 :: 		while (1)
L_main2:
;LFC_P2B.c,45 :: 		unsigned short value = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       main_value_L1+0 
;LFC_P2B.c,47 :: 		unsigned short decimal = BinaryToDecimal(value);
	MOVF        main_value_L1+0, 0 
	MOVWF       FARG_BinaryToDecimal_binary+0 
	CALL        _BinaryToDecimal+0, 0
	MOVF        R0, 0 
	MOVWF       main_decimal_L1+0 
;LFC_P2B.c,50 :: 		if (!PORTD.B3)
	BTFSC       PORTD+0, 3 
	GOTO        L_main4
;LFC_P2B.c,52 :: 		DisplayDigit(decimal / 1000 % 10); // D�gito de los miles
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        main_decimal_L1+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_DisplayDigit_digit+0 
	CALL        _DisplayDigit+0, 0
;LFC_P2B.c,53 :: 		Delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
;LFC_P2B.c,54 :: 		}
L_main4:
;LFC_P2B.c,55 :: 		if (!PORTD.B2)
	BTFSC       PORTD+0, 2 
	GOTO        L_main6
;LFC_P2B.c,57 :: 		DisplayDigit(decimal / 100 % 10); // D�gito de las centenas
	MOVLW       100
	MOVWF       R4 
	MOVF        main_decimal_L1+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_DisplayDigit_digit+0 
	CALL        _DisplayDigit+0, 0
;LFC_P2B.c,58 :: 		Delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
;LFC_P2B.c,59 :: 		}
L_main6:
;LFC_P2B.c,60 :: 		if (!PORTD.B1)
	BTFSC       PORTD+0, 1 
	GOTO        L_main8
;LFC_P2B.c,62 :: 		DisplayDigit(decimal / 10 % 10); // D�gito de las decenas
	MOVLW       10
	MOVWF       R4 
	MOVF        main_decimal_L1+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_DisplayDigit_digit+0 
	CALL        _DisplayDigit+0, 0
;LFC_P2B.c,63 :: 		Delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
;LFC_P2B.c,64 :: 		}
L_main8:
;LFC_P2B.c,65 :: 		if (!PORTD.B0)
	BTFSC       PORTD+0, 0 
	GOTO        L_main10
;LFC_P2B.c,67 :: 		DisplayDigit(decimal % 10); // D�gito de las unidades
	MOVLW       10
	MOVWF       R4 
	MOVF        main_decimal_L1+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_DisplayDigit_digit+0 
	CALL        _DisplayDigit+0, 0
;LFC_P2B.c,68 :: 		Delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
;LFC_P2B.c,69 :: 		}
L_main10:
;LFC_P2B.c,70 :: 		}
	GOTO        L_main2
;LFC_P2B.c,71 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
