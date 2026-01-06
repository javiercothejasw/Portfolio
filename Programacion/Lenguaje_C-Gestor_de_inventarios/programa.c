#include "src/cajas.h"
#include "src/pokemon.h"
#include "src/gestion_cajas.h"
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define MAX_LINEA_ENTRADA 50

void imprimir_menu()
{
	printf("\n\n--------------MENU--------------\n\n");
	printf("I : Mostrar inventario\n");
	printf("C : Cargar otra caja\n");
	printf("M : Combinar cajas\n");
	printf("D : Mostrar caja\n");
	printf("B : Buscar caja\n");
	printf("Q : Salir del programa\n\n");
	printf("Seleccione una de las opciones disponibles:\n");
}

void leer_entrada_por_teclado(char entrada[MAX_LINEA_ENTRADA])
{
	entrada = fgets(entrada, MAX_LINEA_ENTRADA, stdin);
	size_t final_string = strlen(entrada)-1;
	entrada[final_string] = '\0';
}

void realizar_acciones(gestion_cajas_t *gestion, char entrada[MAX_LINEA_ENTRADA], bool *salir)
{
	if(entrada[0] == 'I' || entrada[0] == 'i'){
		mostrar_inventario(gestion);
		return;
	}
	if(entrada[0] == 'C' || entrada[0] == 'c'){
		printf("Por favor ingrese un nombre de archivo\n");
		char nombre_archivo[MAX_LINEA_ENTRADA];
		leer_entrada_por_teclado(nombre_archivo);
		cargar_otra_caja(gestion, nombre_archivo);
		return;
	}
	if(entrada[0] == 'M' || entrada[0] == 'm'){
		printf("Ingrese el nombre de la primera caja\n");
		char nombre_1[MAX_LINEA_ENTRADA];
		leer_entrada_por_teclado(nombre_1);

		printf("Ingrese el nombre de la segunda caja\n");
		char nombre_2[MAX_LINEA_ENTRADA];
		leer_entrada_por_teclado(nombre_2);

		printf("Ingrese el nombre de la nueva caja combinada\n");
		char nombre_caja_combinada[MAX_LINEA_ENTRADA];
		leer_entrada_por_teclado(nombre_caja_combinada);

		combinar_cajas(gestion, nombre_1, nombre_2, nombre_caja_combinada);
		return;
	}
	if(entrada[0] == 'D' || entrada[0] == 'd'){
		printf("Ingrese el nombre de la caja que quiere mostrar\n");
		char caja[MAX_LINEA_ENTRADA];
		leer_entrada_por_teclado(caja);
		mostrar_caja(gestion, caja);
		return;
	}
	if(entrada[0] == 'B' || entrada[0] == 'b'){
		printf("Ingrese un nombre de pokemon\n");
		char pokemon[MAX_LINEA_ENTRADA];
		leer_entrada_por_teclado(pokemon);
		buscar_caja(gestion, pokemon);
		return;
	}
	if(entrada[0] == 'Q' || entrada[0] == 'q'){
		salir_del_programa(gestion);
		*salir = true;
		return;
	}

	printf("Ingreso una opcion invalida, intente de nuevo\n");
}

int main(int argc, char *argv[])
{
	gestion_cajas_t *gestion = cargar_cajas(argc, argv);

	if(!gestion){
		printf("No se pudo cargar ninguna caja, ejecute el programa de nuevo\n");
		return 0;
	}
	bool salir = false;

	while(!salir){
		imprimir_menu();
		char entrada[MAX_LINEA_ENTRADA];
		leer_entrada_por_teclado(entrada);
		if(strlen(entrada) == 1){
			realizar_acciones(gestion, entrada, &salir);

		} else { 
			printf("Ingreso una opcion invalida, intente de nuevo\n");
		}
	}

	printf("SALISTE DEL PROGRAMA\n");

	return 0;
}

