#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 6/LFC_P6D/LFC_P6D.c"
unsigned short aux;
char txt[14], let;
unsigned out;
char cont = 0;


sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

void interrupt()
{
 if (INTCON.INT0IF && INTCON.INT0IE)
 {
 cont++;

 if (cont > 2)
 {
 cont = 0;
 }

 ADCON0.B2 = 1;

 INTCON.INT0IF = 0;
 }

 if (INTCON.TMR0IF)
 {
 TMR0H = (18661 >> 8);
 TMR0L = 18661;

 ADCON0.B2 = 1;

 INTCON.TMR0IF = 0;
 }

 if (PIR1.ADIF)
 {
 aux = ADRESL + (ADRESH << 8);
 out = (4.88e-1) * aux;

 if (cont == 0 )
 {
 let = 'C';
 }
 else if (cont == 1)
 {
 out = out + 273, 15;
 let = 'K';
 }
 else if (cont == 2)
 {
 out = ((1) * out) + 32;
 let = 'F';
 }

 LCD_cmd(_LCD_CLEAR);
 FloatToStr(out, txt);

 Lcd_out(1, 1, txt);
 Lcd_Chr_cp(223);
 Lcd_Chr_cp(let);

 PIR1.ADIF = 0;
 }
}
void main()
{
 TRISB.B0 = 1;

 ADCON1 = 0x89;
 ADCON0 = 0x99;

 Lcd_Init();

 T0CON = 0x85;
 TMR0H = (18661 >> 8);
 TMR0L = 18661;






 INTCON2.INTEDG0 = 1;
 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;
 INTCON2.RBPU = 0;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 PIR1.ADIF = 0;
#line 111 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 6/LFC_P6D/LFC_P6D.c"
 PIE1.ADIE = 1;

 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 ADCON0.B2 = 1;

 while (1)
 ;
}
