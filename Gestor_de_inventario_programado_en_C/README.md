# Inventario de Pokemones

## Descripcion
Aplicación de consola para Linux desarrollada en C que permite gestionar inventarios de Pokemones. El sistema permite administrar cajas que contienen pokemones, podremos visualizar el contenido de una caja, buscar un Pokemon entre todas las cajas, y demas opciones disponibles.

- Al ejecutar el programa deberemos indicar los archivos con los cuales crearemos las cajas.
  
- Tendremos un Menu que nos indicara las acciones disponibles para realizar con las cajas.

- Todas las funcionalidades estan implementadas reservando y utilizando espacio en memoria.

- Al finalizar el programa todo el espacio en memoria utilizado se liberara correctamente.

## Compilacion y ejecucion

El juego debera compilarse y ejecutarse en entornos Linux o similares con las siguientes lineas de codigo:

### Compilacion

    gcc programa.c src/*.c -o programa

### Ejecucion
Al ejecutar el programa deberemos indicar los archivos con los cuales crearemos las cajas (nombre_archivo, nombre_archivo_2)

    ./programa caja_1.csv caja_2.csv 
    
    ./programa [nombre_archivo] [nombre_archivo_2] [....] 

### Formato archivo
    Nombre;Nivel;Ataque;Defensa
    
    Ejemplo:
    
    Pikachu;15;15;30
    Charmander;14;15;45
    Greninja;20;12;50

## Conceptos aplicados

- Implementacion y utilizacion de Tipos de datos abstractos(TDA): Arbol binario de busqueda(ABB), Listas, Hash.

- Lectura de archivos y carga de datos.

- Utilizacion de memoria Dinamica y Punteros.

- Reservacion de memoria(malloc) y liberacion correcta de la memoria que deja de utilizarse(free).

- Modularizacion del codigo.

Consultas 

    javiercothejainfo@gmail.com
