#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 5/LFC_P5B/LFC_P5B.c"
unsigned short q;

void interrupt()
{
 if(!q)
 {
 if(!PORTA.B0)
 {
 PORTA.B5=0;
 q=0;
 }else if (PORTA.B0)
 {
 PORTA.B5=0;
 q=1;
 }
 } else if(q)
 {
 if(!PORTA.B0)
 {
 PORTA.B5=1;
 q=2;
 }else if (PORTA.B0)
 {
 PORTA.B5=0;
 q=1;
 }
 } else if(q==2)
 {
 if(!PORTA.B0)
 {
 PORTA.B5=1;
 q=2;
 }else if (PORTA.B0)
 {
 PORTA.B5=1;
 q=3;
 }
 } else if(q==3)
 {
 if(!PORTA.B0)
 {
 PORTA.B5=0;
 q=0;
 }else if (PORTA.B0)
 {
 PORTA.B5=1;
 q=3;
 }
 }

 INTCON.TMR0IF = 0;
}

void main()
{

 ADCON1 = 0x07;

 TRISA.B0 = 1;
 TRISA.B5 = 0;

 PORTA.B5=0;
 q=0;

 T0CON = 0x81;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 INTCON.GIE = 1;



 TMR0H = (15536 >> 8);
 TMR0L = 15536;

 while (1);
}
