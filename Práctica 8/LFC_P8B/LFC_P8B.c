void main() {

     TRISC.B0 = 0;
     PORTC.B0 = 1;
     
     SPI1_Init();
     
     PORTC.B0 = 0;
     
     SPI1_Write(849>>6);
     SPI1_Write(849<<2);
     
     PORTC.B0 = 1;
     
     while(1);

}