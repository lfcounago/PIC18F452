#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 3/LFC_P3A/LFC_P3A.c"
void main()
{

 unsigned short anterior = 1;
 ADCON1 = 0x07;

 TRISB.B2 = 1;
 TRISB.B3 = 0;
 PORTB.B2 = 1;
 PORTB.B3 = 0;
 while(1)
 {
 anterior = PORTB.B2;
 delay_ms(100);
 if((anterior == 1) && (PORTB.B2 == 0)){
 PORTB.B3 = !PORTB.B3;
 }
 }
}
