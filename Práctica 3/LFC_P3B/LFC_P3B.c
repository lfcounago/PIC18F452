void interrupt(){

    INTCON3.INT2IF = 0; // se borra el flag de la interrupci�n INT2
    PORTB.B3 = !PORTB.B3; //Se enciende o apaga el LED

}

void main() {

    ADCON1 = 0x07; //configuraci?n de los canales anal?gicos (AN) como digitales
    // configuracion de puertos
    TRISB.B2 = 1; //se declara B2 como una entrada digital
    TRISB.B3 = 0; //se declara B3 como una salida digital
    PORTB.B2 = 1;
    PORTB.B3 = 0;

    INTCON2.INTEDG2 = 1; //la interrupci�n la provoca un flanco de subida (x=1)/ bajada (x=0)
    INTCON3.INT2IF = 0; // se pone el flag de la interrupci�n INT2 a 0
    INTCON3.INT2IE = 1; // se habilita la interrupci�n INT2
    INTCON.GIE = 1; // se habilitan las interrupciones en general
    while(1);
}
