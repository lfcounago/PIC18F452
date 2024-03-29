unsigned int aux = 0;
char txt[14];
float alfa;
char x = 0;

// Configuracio�n del LCD
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D4 at RD4_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D4_Direction at TRISD4_bit;

// Configuramos la interrupci�n
void interrupt()
{
    if (INTCON.TMR0IF) // Comprueba el flag de interrupci�n del timer est� ejecutada(Por eso se iguala a 1)
    {
        INTCON.TMR0IF = 0;    // Deshabilita el flag interrupci�n
        TMR0H = (18661 >> 8); // Parte alta
        TMR0L = 18661;        // Parte baja
        ADCON0.B2 = 1;        // Activa conversi�n(de anal�gico a digital)
        PORTC.B0 = !PORTC.B0;
    }
    if (PIR1.ADIF) // Si finaliza la conversi�n
    {
        PIR1.ADIF = 0; // Pones la conversi�n sin finalizar

        aux = ADRESL;              // Resultado del AD
        aux = aux + (ADRESH << 8); // Resultado del AD
        alfa = aux * 0.48875855;   // T=100*Vout

        floatToStr(alfa, txt); // Convertir para que se muestre en LCD
        Lcd_Cmd(_LCD_CLEAR);
        LCD_out(1, 1, txt); // Lo muestra
    }
}
void main()
{
    TRISE.B0 = 1; // Se activa como entrada el bit 0 del E

    ADCON1 = 0x89; // Registro ADCON
    ADCON0 = 0x99; // Registro ADCON

    LCD_init(); // Inicia el LCD

    T0CON = 0x85;         // Configurar timer0
    TMR0H = (18661 >> 8); // Parte alta
    TMR0L = 18661;        // Parte baja

    INTCON.TMR0IF = 0; // Deshabilita el flag interrupci�n
    INTCON.TMR0IE = 1; // Habilita la interrupci�n.

    PIR1.ADIF = 0; // Deshabilito el flag de la conversi�n
    PIE1.ADIE = 1; // Habilito la conversi�n

    INTCON.PEIE = 1; // Es de tipo core
    INTCON.GIE = 1;  // Se habilita las interrupciones

    ADCON0.B2 = 1; // Activa conversi�n(de anal�gico a digital)

    while (1);
}