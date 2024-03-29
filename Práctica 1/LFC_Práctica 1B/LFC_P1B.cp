#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 1/LFC_Práctica 1-B/LFC_P1B.c"

char x[9] = {0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF, 0x00};

void main()
{

 int i;

 ADCON1 = 0X07;


 TRISC = 0;
 PORTC = 0;

 while (1)
 {
 for (i = 0; i < 9; i++)
 {
 PORTC = x[i];
 delay_ms(100);


 }
 }
}
