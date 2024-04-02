// Lcd pinout settings
sbit LCD_RS at RC2_bit;
sbit LCD_EN at RC3_bit;
sbit LCD_D7 at RC7_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D4 at RC4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC3_bit;
sbit LCD_D7_Direction at TRISC7_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D4_Direction at TRISC4_bit;

float lectura, aux, imprimir;
char txt[14];
unsigned short cont;

void imprimirValor(){
     if(cont == 0){
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(lectura, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("kPa");
     }
     if(cont == 1){
       imprimir = lectura / 6.8927;
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(imprimir, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("Psi");
     }
     if(cont == 2){
       imprimir = lectura / 101.325;
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(imprimir, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("Atm");
     }
     if(cont == 3){
       imprimir = lectura / 0.1;
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(imprimir, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("mBar");
     }
     if(cont == 4){
       imprimir = lectura / 0.13328;
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(imprimir, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("mmHg");
     }
     if(cont == 5){
       imprimir = lectura / 0.001;
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(imprimir, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("N/m2");
     }
     if(cont == 6){
       imprimir = lectura / 98.1;
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(imprimir, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("Kg/cm2");
     }
     if(cont == 7){
       imprimir = lectura / 98.1;
       Lcd_Cmd(_LCD_CLEAR);
       FloatToStr(imprimir, txt);
       Lcd_Out(1,1, txt);
       Lcd_Out_CP("kp/cm2");
     }
}

void interrupt(){
     if(INTCON3.INT1IF){
      cont++;
      if(cont >= 8){
        cont = 0;
      }
      imprimirValor();
      INTCON3.INT1IF = 0;
     }
     if(INTCON.TMR0IF){
          ADCON0.B2 = 1;
          INTCON.TMR0IF = 0;
     }
     if(PIR1.ADIF){
          aux = (ADRESH << 8) + ADRESL;
          aux *= 0.0048875;
          lectura = 54.2*aux - 14.11;
          imprimirValor();
          INTCON.TMR0IF = 0;
          TMR0H = (3036 >> 8);
          TMR0L = 3036;
          PORTB.B0 = !PORTB.B0;
          PIR1.ADIF = 0;
     }

}

void main() {

    TRISB.B0 = 0;
    TRISB.B1 = 1;
    PORTB.B0 = 0;

    ADCON0 = 0xB1;
    ADCON1 = 0x80;

    PIR1.ADIF = 0;
    PIE1.ADIE = 1;
    INTCON.PEIE = 1;

    T0CON = 0x85;
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;

    INTCON2.INTEDG1 = 0;
    INTCON3.INT1IF = 0;
    INTCON3.INT1IE = 1;

    INTCON.GIE = 1;

    TMR0H = (3036 >> 8);
    TMR0L = 3036;

    LCD_Init();

    while(1);
}