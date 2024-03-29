#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicaci�n Espec�fica/Pr�cticas 2024/LFC_Pr�ctica 5/LFC_P5C/LFC_P5C.c"
unsigned short i=0;
void interrupt()
{
 if((INTCON3.INT1IF)&&(INTCON3.INT1IE))
 {
 PORTC.B0=1;
 T0CON=0x87;
 TMR0H=(18661>>8);
 TMR0L=18661;
 INTCON3.INT1IF=0;
 INTCON3.INT1IE=0;
 }
 if((INTCON.TMR0IF)&&(INTCON.TMR0IE))
 {
 INTCON.TMR0IF = 0;
 i++;
 if(i<2){
 TMR0H=(18661>>8);
 TMR0L=18661;
 }else{
 PORTC.B0=0;
 T0CON=0;
 INTCON3.INT1IF=0;
 INTCON3.INT1IE=1;
 i=0;
 }
 }
}

void main() {
 TRISB.B1 = 1;
 TRISC.B0 = 0;
 PORTC.B0 = 0;

 INTCON2.INTEDG1 = 1;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 1;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 INTCON.GIE = 1;

 while(1);
}
