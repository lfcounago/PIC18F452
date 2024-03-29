#line 1 "C:/Users/luisf/Desktop/ESEI 23-24/2C/HAE - Hardware de Aplicación Específica/Prácticas 2024/LFC_Práctica 3/LFC_P3B/LFC_P3B.c"
void interrupt(){

 INTCON3.INT2IF = 0;
 PORTB.B3 = !PORTB.B3;

}

void main() {

 ADCON1 = 0x07;

 TRISB.B2 = 1;
 TRISB.B3 = 0;
 PORTB.B2 = 1;
 PORTB.B3 = 0;

 INTCON2.INTEDG2 = 1;
 INTCON3.INT2IF = 0;
 INTCON3.INT2IE = 1;
 INTCON.GIE = 1;
 while(1);
}
