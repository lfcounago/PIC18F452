// N�meros para representar cada d�gito en el display de 7 segmentos
unsigned short numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

// Funci�n para mostrar un d�gito en el display de 7 segmentos
void MostrarDigito(unsigned short digit)
{
  // Asigna al puerto C al d�gito
  PORTC = numeros[digit];
}

// Funci�n para convertir un n�mero binario a decimal
unsigned short BinarioADecimal(unsigned short binario)
{
  unsigned short decimal = 0;
  unsigned short base = 1;

  // Mientras haya d�gitos en el n�mero binario
  while (binario)
  {
    // A�ade al n�mero decimal el d�gito binario actual multiplicado por la base actual
    decimal += (binario % 10) * base;
    // Elimina el d�gito binario actual
    binario /= 10;
    // Duplica la base
    base *= 2;
  }

  // Devuelve el n�mero decimal
  return decimal;
}

void main()
{
  // Configura PORTC como salida
  TRISC = 0;
  // Configura PORTB como entrada
  TRISB = 1;
  // Configura PORTD como salida
  TRISD = 0;

  // Bucle infinito
  while (1)
  {
    // Lee el valor de PORTB
    unsigned short valorBinario = PORTB;
    // Convierte el valor binario a decimal
    unsigned short decimal = BinarioADecimal(valorBinario);

    // Si el bit correspondiente en PORTD es 0, muestra el d�gito correspondiente en el display
    if (!PORTD.B3)
    {
      MostrarDigito(decimal / 1000 % 10); // D�gito de los miles
      Delay_ms(15);
    }
    if (!PORTD.B2)
    {
      MostrarDigito(decimal / 100 % 10); // D�gito de las centenas
      Delay_ms(15);
    }
    if (!PORTD.B1)
    {
      MostrarDigito(decimal / 10 % 10); // D�gito de las decenas
      Delay_ms(15);
    }
    if (!PORTD.B0)
    {
      MostrarDigito(decimal % 10); // D�gito de las unidades
      Delay_ms(15);
    }
  }
}