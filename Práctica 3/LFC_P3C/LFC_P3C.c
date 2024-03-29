unsigned short unidades = 6;
unsigned short decenas = 9;
unsigned short numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

void interrupt()
{
    if(INTCON.INT0IF && INTCON.INT0IE){
         if(unidades==9 && decenas==9){
              unidades=0;
              decenas=0;
         } else if(unidades==9){
           decenas++;
           unidades=0;
         }else{
           unidades++;
         }
        INTCON.INT0IF=0;
      }


    if(INTCON3.INT1IF==1 && INTCON3.INT1IE==1){
       if(unidades==0 && decenas==0){
              unidades=9;
              decenas=9;
       }else if(unidades==0){
         unidades=9;
         decenas--;
       }else{
         unidades--;
       }
       INTCON3.INT1IF=0;
      }

}
void main()
{
    TRISD = 0; // se configura el puerto D como salida
    TRISE = 0; // se configura el puerto E como salida

    PORTD = 0; // se pone el puerto D en 0
    PORTE = 0; // se pone el puerto E en 0

    // configuraciï¿½n de la interrupciï¿½n INT0
    TRISB.B0 = 1;        // se configura RB0 como entrada
    INTCON2.INTEDG0 = 1; // la interrupciï¿½n la provoca un flanco de subida (x=1)/ bajada (x=0)
    INTCON.INT0IF = 0;   // se pone el flag de la interrupciï¿½n INT0 a 0
    INTCON.INT0IE = 1;   // se habilita la interrupciï¿½n INT0

    // configuraciï¿½n de la interrupciï¿½n INT1
    TRISB.B1 = 1;        // se configura RB1 como entrada
    INTCON2.INTEDG1 = 1; // la interrupciï¿½n la provoca un flanco de subida (x=1)/ bajada (x=0)
    INTCON3.INT1IF = 0;  // se pone el flag de la interrupciï¿½n INT1 a 0
    INTCON3.INT1IE = 1;  // se habilita la interrupciï¿½n INT1

    // se habilitan las interrupciones en general
    INTCON.GIE = 1;

    while (1)
    {
        PORTD = numeros[decenas];
        PORTE.B0 = 0;
        delay_ms(20);
        PORTE.B0 = 1;
        PORTD = numeros[unidades];
        PORTE.B1 = 0;
        delay_ms(20);
        PORTE.B1 = 1;
    }
}