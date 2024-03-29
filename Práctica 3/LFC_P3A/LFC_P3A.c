void main()
{
    // declaracion de variables
    unsigned short anterior = 1;
    ADCON1 = 0x07; // configuraci�n de los canales anal?gicos (AN) como digitales
    // configuracion de puertos
    TRISB.B2 = 1; // se declara B2 como una entrada digital
    TRISB.B3 = 0; // se declara B2 como una salida digital
    PORTB.B2 = 1;
    PORTB.B3 = 0;
    while (1)
    {
        anterior = PORTB.B2;
        delay_ms(100);
        if ((anterior == 1) && (PORTB.B2 == 0))
        {
            PORTB.B3 = !PORTB.B3;
        }
    }
}
