char x;
unsigned int lectura;
unsigned int primera = 0;
char txt[14];
 
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

void interrupt()
{
      if(primera == 0)
      {
         primera++;
         Lcd_Out(1,1, "Tiempo: ");
         T0CON.TMR0ON = 1;
         TMR0H = 0;
         TMR0L = 0;
      } else
      {
         T0CON.TMR0ON = 0;
         lectura = TMR0L;
         lectura = lectura + (TMR0H << 8);
         lectura = (lectura * 0.000128);
         FloatToStr(lectura, txt);
         Lcd_Out(2,1,txt);
      }

      x = PORTB; // hay que leer el puerto B antes de borrar el flag
      INTCON.RBIF = 0; // se borra el flag
}

void main()
{
     ADCON1 = 0x07;

     TRISB.B4 = 1;
     
     T0CON = 0x07;
     INTCON.TMR0IF = 0; // se pone el flag a 0
     INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0

     x = PORTB;
     INTCON.RBIF = 0; // se pone el flag a 0
     INTCON.RBIE = 1; // se habilita la interrupción por cambio de nivel
     INTCON.GIE = 1; // se habilitan las interrupciones en general
     
     Lcd_Init();
         
     while(1);
     
}