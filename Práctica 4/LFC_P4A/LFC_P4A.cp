#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 4/LFC_P4A/LFC_P4A.c"
#line 1 "c:/users/luisf/desktop/esei 23-24/2c/hae - hardware de aplicación específica/prácticas 2024/lfc_práctica 4/lfc_p4a/tecla12int.h"
#line 24 "c:/users/luisf/desktop/esei 23-24/2c/hae - hardware de aplicación específica/prácticas 2024/lfc_práctica 4/lfc_p4a/tecla12int.h"
unsigned char tecla()
{

unsigned char columna=0, fila, aux1=0x10, aux2;

unsigned char teclado[4][3]={{49, 50, 51},{52, 53, 54},{55, 56, 57}, {42, 48, 35}};

delay_ms( 10 );

 for(fila=0; fila< 4 ; fila++)
 {
 if((PORTB&aux1)==0x00) break;
 aux1=(aux1<<1);
 }

 PORTB=0x01;

 while((PORTB& 0xF0 )!= 0xF0 )
 {
 PORTB=(PORTB<<1);
 columna++;
 }


 PORTB=0x00;

 do
 {delay_ms(2);
 }while((PORTB&0xF0)!=0xF0);



 aux2=teclado[fila][columna];
 return aux2;
}
#line 3 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 4/LFC_P4A/LFC_P4A.c"
char x;
char key;


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
 key = tecla();
 Lcd_Chr(1, 1, key);
 x = PORTB;
 INTCON.RBIF=0;
}


void main() {

 TRISB = 0xF0;
 PORTB = 0;
 TRISD = 0x00;
 PORTD = 0x00;

 INTCON2.RBPU = 0;
 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 Lcd_Init();

 while(1);

}
