/*Estructura básica de un programa */

// declaracion de variables globales

// declaracion (y definicion) de funciones

// declaracion y definicion de la ISR (rutina de servicio de interrupciones)

void main()
{
    // declaracion de variables

    ADCON1 = 0x07; // configuraci�n de los canales anal�gicos (AN) como digitales

    // configuracion de puertos
    TRISC.B0 = 0; // se declara RC0 como una salida digital
    PORTC.B0 = 0; // se pone el terminal RC0 a 0

    // configuracion e inicializacion de los m�dulos del PIC que se vayan a utilizar

    // configuraci�n de interrupciones (si se utilizan)

    while (1) // bucle infinito
    {
        PORTC.B0 = 1;  // se pone el terminal RC0 a 1
        delay_ms(600); // se introduce un retardo de 200ms en la ejecuci�n del c�digo
        PORTC.B0 = 0;  // se pone el terminal RC0 a 0
        delay_ms(400); // se introduce un retardo de 200ms en la ejecuci�n del c�digo
    }
}
// Componentes ISIS: PIC18F452, RES, LED-BLUE