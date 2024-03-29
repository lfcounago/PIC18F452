#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 2/LFC_P2-A/LFC_P2A.c"

void main()
{

 unsigned short numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7C, 0x07, 0x7F, 0x67};

 ADCON1 = 0x07;
 int dec;
 int unid;
 int cont;


 TRISD = 0;
 PORTD = 0;
 TRISA = 0;
 PORTA = 0;

 int segundos = 0;

 while (1)
 {
 for (unid = 0; unid < 6; unid++)
 {
 for (dec = 0; dec < 10; dec++)
 {
 for (cont = 0; cont < 25; cont++)
 {
 PORTD = numeros[dec];
 PORTA.B0 = 1;
 delay_ms(20);
 PORTA.B0 = 0;


 PORTD = numeros[unid];
 PORTA.B1 = 1;
 delay_ms(20);
 PORTA.B1 = 0;
 }
 }
 }
 }
}
