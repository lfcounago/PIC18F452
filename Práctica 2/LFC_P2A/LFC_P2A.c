
void main()
{
  // declaracion de variables
  unsigned short numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7C, 0x07, 0x7F, 0x67};

  ADCON1 = 0x07; // configuraci�n de los canales anal�gicos (AN) como digitales
  int dec;
  int unid;
  int cont;

  // configuracion de puertos
  TRISD = 0; // se declara RD como una salida digital
  PORTD = 0; // se pone el terminal RD a 0
  TRISA = 0; // se declara RA como una salida digital
  PORTA = 0; // se pone el terminal RA a 0

  int segundos = 0;

  while (1) // bucle infinito
  {
    for (unid = 0; unid < 6; unid++)
    {
      for (dec = 0; dec < 10; dec++)
      {
        for (cont = 0; cont < 25; cont++)
        {
          PORTD = numeros[dec];
          PORTA.B0 = 1; // Activa el display de decenas
          delay_ms(20);
          PORTA.B0 = 0; // Desactiva el display de decenas
          // delay_ms(20);

          PORTD = numeros[unid];
          PORTA.B1 = 1; // Activa el display de unidades
          delay_ms(20);
          PORTA.B1 = 0; // Desactiva el display de unidades
        }
      }
    }
  }
}