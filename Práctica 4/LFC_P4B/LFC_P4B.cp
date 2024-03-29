#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 4/LFC_P4B/LFC_P4B.c"
char x;
char txt[4];
unsigned short pulsos=0;
unsigned short flanco=0;

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

void interrupt(){

 if(INTCON.RBIF && INTCON.RBIE){

 ByteToStr(pulsos/2,txt);
 Lcd_Out(1, 1, "Pulsos: ");
 Lcd_Out_CP(txt);
 x= PORTB;
 INTCON.RBIF=0;
 pulsos++;
 }
}


void main()
{

 ADCON1=0x07;

 TRISA.B4=1;
 TRISB.B4=1;

 INTCON2.RBPU = 0;
 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 0;
 INTCON.GIE = 1;

 LCD_INIT();


 while(1)
 {
 if(PORTA.B4 && flanco)
 {
 INTCON.RBIE=1;
 delay_ms(6000);
 pulsos=0;
 }
 INTCON.RBIE=0;
 flanco=PORTA.B4;
 }
}
