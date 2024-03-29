unsigned short q;

void interrupt()
{
  if (!q)
  {
    if (!PORTA.B0)
    {
      PORTA.B5 = 0;
      q = 0;
    }
    else if (PORTA.B0)
    {
      PORTA.B5 = 0;
      q = 1;
    }
  }
  else if (q)
  {
    if (!PORTA.B0)
    {
      PORTA.B5 = 1;
      q = 2;
    }
    else if (PORTA.B0)
    {
      PORTA.B5 = 0;
      q = 1;
    }
  }
  else if (q == 2)
  {
    if (!PORTA.B0)
    {
      PORTA.B5 = 1;
      q = 2;
    }
    else if (PORTA.B0)
    {
      PORTA.B5 = 1;
      q = 3;
    }
  }
  else if (q == 3)
  {
    if (!PORTA.B0)
    {
      PORTA.B5 = 0;
      q = 0;
    }
    else if (PORTA.B0)
    {
      PORTA.B5 = 1;
      q = 3;
    }
  }

  INTCON.TMR0IF = 0;
}

void main()
{

  ADCON1 = 0x07;

  TRISA.B0 = 1;
  TRISA.B5 = 0;

  PORTA.B5 = 0;
  q = 0;

  T0CON = 0x81; // Prescaler = 4

  INTCON.TMR0IF = 0; // se pone el flag a 0
  INTCON.TMR0IE = 1; // se habilita la interrupci�n del Timer 0
  INTCON.GIE = 1;    // se habilitan las interrupciones en general

  // T0CON.TMR0ON = 1;

  TMR0H = (15536 >> 8);
  TMR0L = 15536;

  while (1)
    ;
}