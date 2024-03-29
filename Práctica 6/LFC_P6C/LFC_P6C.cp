#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 6/LFC_P6C/LFC_P6C.c"
unsigned int aux = 0;
char txt[14];
float alfa;
char x = 0;


sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D4 at RD4_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D4_Direction at TRISD4_bit;


void interrupt()
{
 if (INTCON.TMR0IF)
 {
 INTCON.TMR0IF = 0;
 TMR0H = (18661 >> 8);
 TMR0L = 18661;
 ADCON0.B2 = 1;
 PORTC.B0 = !PORTC.B0;
 }
 if (PIR1.ADIF)
 {
 PIR1.ADIF = 0;

 aux = ADRESL;
 aux = aux + (ADRESH << 8);
 alfa = aux * 0.48875855;

 floatToStr(alfa, txt);
 Lcd_Cmd(_LCD_CLEAR);
 LCD_out(1, 1, txt);
 }
}
void main()
{
 TRISE.B0 = 1;

 ADCON1 = 0x89;
 ADCON0 = 0x99;

 LCD_init();

 T0CON = 0x85;
 TMR0H = (18661 >> 8);
 TMR0L = 18661;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;

 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 ADCON0.B2 = 1;

 while (1);
}
