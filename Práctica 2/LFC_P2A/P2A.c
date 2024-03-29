void main()
{
  unsigned short numeros[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7C,0x07,0x7F,0x67};
  int dec;
  int unid;
  int cont;

  ADCON1 = 0x07;

  // configuracion de puertos
  TRISD = 0;
  PORTD = 0;
  TRISA = 0;
  PORTA = 0;

  while (1) // bucle infinito
  {
    for(unid=0;unid<6;unid++){
        for(dec=0;dec<10;dec++){
            for(cont=0;cont<25;cont++){
                PORTD = numeros[dec];
                PORTA.B0 = 1 ;
                delay_ms(20);
                PORTA.B0 = 0;
                //delay_ms(20);
                PORTD = numeros[unid];
                PORTA.B1 = 1 ;
                delay_ms(20);
                PORTA.B1 = 0;
            }
        }
    }
  }
}