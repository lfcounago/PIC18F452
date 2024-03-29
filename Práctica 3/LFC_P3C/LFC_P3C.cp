#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 3/LFC_P3C/LFC_P3C.c"
unsigned short unidades = 6;
unsigned short decenas = 9;
unsigned short numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

void interrupt()
{
 if(INTCON.INT0IF && INTCON.INT0IE){
 if(unidades==9 && decenas==9){
 unidades=0;
 decenas=0;
 } else if(unidades==9){
 decenas++;
 unidades=0;
 }else{
 unidades++;
 }
 INTCON.INT0IF=0;
 }


 if(INTCON3.INT1IF==1 && INTCON3.INT1IE==1){
 if(unidades==0 && decenas==0){
 unidades=9;
 decenas=9;
 }else if(unidades==0){
 unidades=9;
 decenas--;
 }else{
 unidades--;
 }
 INTCON3.INT1IF=0;
 }

}
void main()
{
 TRISD = 0;
 TRISE = 0;

 PORTD = 0;
 PORTE = 0;


 TRISB.B0 = 1;
 INTCON2.INTEDG0 = 1;
 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;


 TRISB.B1 = 1;
 INTCON2.INTEDG1 = 1;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 1;


 INTCON.GIE = 1;

 while (1)
 {
 PORTD = numeros[decenas];
 PORTE.B0 = 0;
 delay_ms(20);
 PORTE.B0 = 1;
 PORTD = numeros[unidades];
 PORTE.B1 = 0;
 delay_ms(20);
 PORTE.B1 = 1;
 }
}
