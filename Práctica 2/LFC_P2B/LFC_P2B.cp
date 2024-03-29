#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 2/LFC_P2-B/LFC_P2B.c"

unsigned short SEGMENT_MAP[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};


void DisplayDigit(unsigned short digit)
{

 PORTC = SEGMENT_MAP[digit];
}


unsigned short BinaryToDecimal(unsigned short binary)
{
 unsigned short decimal = 0;
 unsigned short base = 1;


 while (binary)
 {

 decimal += (binary % 10) * base;

 binary /= 10;

 base *= 2;
 }


 return decimal;
}

void main()
{

 TRISC = 0;

 TRISB = 1;

 TRISD = 0;


 while (1)
 {

 unsigned short value = PORTB;

 unsigned short decimal = BinaryToDecimal(value);


 if (!PORTD.B3)
 {
 DisplayDigit(decimal / 1000 % 10);
 Delay_ms(15);
 }
 if (!PORTD.B2)
 {
 DisplayDigit(decimal / 100 % 10);
 Delay_ms(15);
 }
 if (!PORTD.B1)
 {
 DisplayDigit(decimal / 10 % 10);
 Delay_ms(15);
 }
 if (!PORTD.B0)
 {
 DisplayDigit(decimal % 10);
 Delay_ms(15);
 }
 }
}
