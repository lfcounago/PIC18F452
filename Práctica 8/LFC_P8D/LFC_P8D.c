unsigned int aux;

void interrupt(){
     if(INTCON.TMR0IF){
        TMR0L = 6;
        ADCON0.B2 = 1;
        
        INTCON.TMR0IF = 0;
     }
     if(PIR1.ADIF) {
        aux = ADRESL + (ADRESH << 8);
        PORTC.B0 = 0;

        SPI1_Write((aux >> 5));
        SPI1_Write((aux << 3));

        PORTC.B0 = 1;
        
        PIR1.ADIF = 0;
     }
}
void main() {

     ADCON0 = 0x49;
     ADCON1 = 0xC0;
     
     SPI1_Init();
     
     TRISA.B1 = 1;
     TRISC.B0 = 0;
     PORTC.B0 = 1;
     
     T0CON = 0xC3;
     
     PIR1.ADIF = 0;
     PIE1.ADIE = 1;
     INTCON.PEIE = 1;
     INTCON.TMR0IF = 0;
     INTCON.TMR0IE = 1;
     INTCON.GIE = 1;
     
     TMR0L = 6;
     ADCON0.B2 = 1;



     while(1);

}