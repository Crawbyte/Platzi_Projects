#include <stdio.h>
int main()
{
    printf("Hello Platzi");
    return 0;
}
Basic types:
Aritmeticos:
    (A) Valores enteros
                    int 2 o 4 bytes -2,147,483,648 to -2,147,483,648
                    unsigned int 0 to 65,535
                    short 2 Bytes 0 to 65,535
                    long 8 bytes 


    (B) Punto flotante 

                    float 4 bytes 6 decimal places
                    double 8 bytes 15 decimal places
                    long double 10 bytes 19 decimal places


    void : Especifica que no hay valor disponible, se usa en tres escenarios
        1.- Función retorna un tipo de datos void
            void funcion()
        2.- Función tiene argumentos de tipo void
            int rand(void)
        3.- Puntero o apuntador que va a la dirección en memoria de un objeto 
        pero no le importa el tipo de dato que tenga
