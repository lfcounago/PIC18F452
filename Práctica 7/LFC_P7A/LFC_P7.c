

// Lcd pinout settings
sbit LCD_RS at RC2_bit;
sbit LCD_EN at RC3_bit;
sbit LCD_D7 at RC7_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D4 at RC4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC3_bit;
sbit LCD_D7_Direction at TRISC7_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D4_Direction at TRISC4_bit;

float lectura, aux, lux;
char txt[14];

void interrupt(){

     if(INTCON.TMR0IF){
          ADCON0.B2 = 1;
          TMR0H = (15536 >> 8);
          TMR0L = 15536;
          INTCON.TMR0IF = 0;
          PORTB.B0 = !PORTB.B0;
     }
     if(PIR1.ADIF){
          aux = (ADRESH << 8) + ADRESL;
          aux *= 0.0048875;
          lectura = 680.0*(5.0/aux - 1.0);
          lux = pow(lectura/127410.0,-1.0/0.8582);
          FloatToStr(lux,txt);
          Lcd_Out(1,1,txt);
          PIR1.ADIF = 0;

     }

}

void main() {
    TRISB.B0 = 0;
    PORTB.B0 = 0;
    
    ADCON0 = 0x71;
    ADCON1 = 0xC0;

    PIR1.ADIF = 0;
    PIE1.ADIE = 1;
    INTCON.PEIE = 1;
    
    T0CON = 0x84;
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;
    
    INTCON.GIE = 1;
    
    TMR0H = (15536 >> 8);
    TMR0L = 15536;

    LCD_Init();

    while(1);
}