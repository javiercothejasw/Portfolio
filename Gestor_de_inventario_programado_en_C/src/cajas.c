#include "cajas.h"
#include "pokemon.h"
#include "abb.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_LINEA_POKEMON 50

struct _caja_t {
	abb_t *abb_caja;
};

int comparar_nombres_pokemon(void *pokemon_1, void *pokemon_2)
{
	return strcmp(pokemon_nombre((pokemon_t*)pokemon_1), pokemon_nombre((pokemon_t*)pokemon_2));
}

caja_t *caja_cargar_archivo(const char *nombre_archivo)
{
	if(!nombre_archivo)
		return NULL;

	FILE* archivo_pokemones = fopen(nombre_archivo, "r");
	if(!archivo_pokemones){
		perror("No se pudo abrir el archivo\n");
		return NULL;
	}

	caja_t *caja_nueva = malloc(sizeof(caja_t));
	if(!caja_nueva){
		fclose(archivo_pokemones);
		return NULL;
	} 
	caja_nueva->abb_caja = abb_crear(comparar_nombres_pokemon);
	if(!caja_nueva->abb_caja){
		fclose(archivo_pokemones);
		free(caja_nueva);
		return NULL;
	}

	char linea_archivo[MAX_LINEA_POKEMON];
	bool condicion = true;

	while(condicion && !feof(archivo_pokemones)){
		int leidos = fscanf(archivo_pokemones, "%s\n", linea_archivo);
		if(leidos == 1){
			pokemon_t *pokemon_nuevo = pokemon_crear_desde_string(linea_archivo);
			if(!pokemon_nuevo){
				fclose(archivo_pokemones);
				abb_destruir_todo(caja_nueva->abb_caja, free);
				free(caja_nueva);
				return NULL;
			}

			caja_nueva->abb_caja = abb_insertar(caja_nueva->abb_caja, pokemon_nuevo);
			if(!caja_nueva->abb_caja){
				free(caja_nueva);
				fclose(archivo_pokemones);
				return NULL;
			}		
		} else{
			abb_destruir_todo(caja_nueva->abb_caja, free);
			caja_nueva = NULL;
			condicion = false;
		}
	}	
	fclose(archivo_pokemones);
	return caja_nueva;
}

bool escribir_archivo(void *pokemon, void *archivo)
{
	fprintf(archivo, "%s;%i;%i;%i\n", pokemon_nombre((pokemon_t*)pokemon), pokemon_nivel((pokemon_t*)pokemon),
		 		pokemon_ataque((pokemon_t*)pokemon), pokemon_defensa((pokemon_t*)pokemon));
	return true;
}

int caja_guardar_archivo(caja_t *caja, const char *nombre_archivo)
{	
	if(!caja || !nombre_archivo)
		return 0;

	FILE* nuevo_archivo = fopen(nombre_archivo, "w");

	int i = (int)abb_con_cada_elemento(caja->abb_caja, INORDEN, escribir_archivo, nuevo_archivo);
	fclose(nuevo_archivo);
	return i;
}

bool agregar_pokemones_en_nueva_caja(void *pokemon, void *nueva_caja)
{
	char linea_pokemon[MAX_LINEA_POKEMON];
	sprintf(linea_pokemon, "%s;%i;%i;%i", pokemon_nombre((pokemon_t*)pokemon), pokemon_nivel((pokemon_t*)pokemon), pokemon_ataque((pokemon_t*)pokemon), pokemon_defensa((pokemon_t*)pokemon));
	pokemon_t *pokemon_nuevo = pokemon_crear_desde_string(linea_pokemon);
	if(!pokemon_nuevo){
		abb_destruir_todo(((caja_t*)nueva_caja)->abb_caja, free);
		return false;
	}

	abb_insertar(((caja_t*)nueva_caja)->abb_caja, pokemon_nuevo);
	return true;
}

caja_t *caja_combinar(caja_t *caja1, caja_t *caja2)
{
	if(!caja1 || !caja2)
		return NULL;

	caja_t *caja_nueva = malloc(sizeof(caja_t));
	if(!caja_nueva)
		return NULL;

	caja_nueva->abb_caja = abb_crear(comparar_nombres_pokemon);
	if(!caja_nueva->abb_caja){
		free(caja_nueva);
		return NULL;
	}

	int iteraciones_caja1 = (int)abb_con_cada_elemento(caja1->abb_caja, PREORDEN, agregar_pokemones_en_nueva_caja, caja_nueva);
	int iteraciones_caja2 = 0;
	if(iteraciones_caja1 == (int)abb_tamanio(caja1->abb_caja)){
		iteraciones_caja2 = (int)abb_con_cada_elemento(caja2->abb_caja, PREORDEN, agregar_pokemones_en_nueva_caja, caja_nueva);
	} else {
		free(caja_nueva);
		caja_nueva = NULL;
	}

	if(iteraciones_caja2 != (int)abb_tamanio(caja2->abb_caja)){
		free(caja_nueva);
		caja_nueva = NULL;
	}

	return caja_nueva;
}

int caja_cantidad(caja_t *caja)
{
	if(!caja)
		return 0;

	return (int)abb_tamanio(caja->abb_caja);
}

struct obtener_pokemon_y_funcion_recorrer{
	int iterador;
	int posicion_n;
	void *elemento;
	void (*funcion)(pokemon_t *);
};

bool obtener_pokemon(void *pokemon, void *aux)
{
	if(((struct obtener_pokemon_y_funcion_recorrer*)aux)->iterador == ((struct obtener_pokemon_y_funcion_recorrer*)aux)->posicion_n){
		((struct obtener_pokemon_y_funcion_recorrer*)aux)->elemento = pokemon;
		return false;
	} else{
		(((struct obtener_pokemon_y_funcion_recorrer*)aux)->iterador)++;
		return true;
	}
}

pokemon_t *caja_obtener_pokemon(caja_t *caja, int n)
{
	if(!caja || (n < 0) || (n >= abb_tamanio(caja->abb_caja)))
		return NULL;

	struct obtener_pokemon_y_funcion_recorrer aux;
	aux.iterador = 0;
	aux.posicion_n = n;
	aux.elemento = NULL;

	abb_con_cada_elemento(caja->abb_caja, INORDEN, obtener_pokemon, &aux);

	return aux.elemento;
}

bool iterar_caja(void *pokemon, void *estructura)
{
	((struct obtener_pokemon_y_funcion_recorrer*)estructura)->funcion((pokemon_t*)pokemon);

	return true;
}

int caja_recorrer(caja_t *caja, void (*funcion)(pokemon_t *))
{	
	if(!caja || !funcion)
		return 0;

	struct obtener_pokemon_y_funcion_recorrer aux;
	aux.funcion = funcion;

	return (int)abb_con_cada_elemento(caja->abb_caja, INORDEN, iterar_caja, &aux);
}

void caja_destruir(caja_t *caja)
{	
	if(!caja)
		return;

	abb_destruir_todo(caja->abb_caja, free);
	free(caja);
}