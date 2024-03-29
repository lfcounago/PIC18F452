// Declaracion de variables globales
char x[9] = {0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF, 0x00};

void main()
{
    // Declaracion de variables
    int i;

    ADCON1 = 0X07; // Configuraci�n de los canales anal�gicos (AN) como digitales

    // Configuracion de puertos
    TRISC = 0; // Se declaran los RC como salidas digital
    PORTC = 0; // Se ponen los terminales RC a 0

    while (1)
    {
        for (i = 0; i < 9; i++)
        {
            PORTC = x[i];
            delay_ms(100);
            // PORTC = 0;
            // delay_ms(100);
        }
    }
}
/*
00000000 0x00
00000001 0x01
00000011 0x03
00000111 0x07
00001111 0x0F
00011111 0x1F
00111111 0x3F
01111111 0x7F
11111111 0xFF
*/