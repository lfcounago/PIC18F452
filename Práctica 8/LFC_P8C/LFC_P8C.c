void main() {
     unsigned int valor=0;
     TRISC.B0 = 0;
     PORTC.B0 = 1;

     SPI1_Init();

     while(1){
        PORTC.B0 = 0;
        SPI1_Write(0);
        SPI1_Write(0);
        PORTC.B0 = 1;
        delay_ms(70);
        valor=1;

        while(valor<1024){
             PORTC.B0 = 0;
             SPI1_Write(valor>>6);
             SPI1_Write(valor<<2);
             PORTC.B0 = 1;
             valor++;
        }
        delay_ms(60);
     }
}