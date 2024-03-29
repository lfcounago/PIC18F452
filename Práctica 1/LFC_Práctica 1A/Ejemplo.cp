#line 1 "C:/Users/Electronica/Desktop/Asignaturas/Clases HAE 21-22/Clases HAE 21-22/1ª Clase HAE PORTs/Primer programa/Ejemplo.c"









void main()
{


 ADCON1 = 0x07;


 TRISC.B0 = 0;
 PORTC.B0 = 0;





 while(1)
 {
 PORTC.B0 = 1;
 delay_ms(600);
 PORTC.B0 = 0;
 delay_ms(400);
 }
}
