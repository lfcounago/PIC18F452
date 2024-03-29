#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 6/LFC_P6B/LFC_P6B.c"
unsigned int aux = 0;
char txt[14];
float alfa;

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
 PIR1.ADIF = 0;

 aux = ADRESL;
 aux = aux + (ADRESH << 8);
 alfa = aux * 0.004887585;

 FloatToStr(alfa, txt);
 Lcd_Cmd(_LCD_CLEAR);
 LCD_out(1, 1, txt);

 delay_ms(1000);

 ADCON0.B2 = 1;
}

void main()
{
 TRISA.B3 = 1;

 ADCON1 = 0x89;
 ADCON0 = 0x19;

 LCD_init();

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;

 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 ADCON0.B2 = 1;

 while(1);
}
