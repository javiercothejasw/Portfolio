#include "gestion_cajas.h"
#include "hash.h"
#include "cajas.h"
#include "lista.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


struct gestion_cajas{
	hash_t *hash_cajas;
	hash_t *indice_pokemon;
	lista_t *lista_cajas;

};

void actualizar_indice(gestion_cajas_t *gestion, caja_t *caja, const char *clave)
{	

	int cantidad_caja = caja_cantidad(caja);
	char *clave_lista = malloc((strlen(clave)+1)*sizeof(char));
	if(!clave_lista){
		return;
	}
	strcpy(clave_lista, clave);
	lista_insertar(gestion->lista_cajas, (void*)clave_lista);

	for(int i = 0; i < cantidad_caja; i++ ){
		if(hash_contiene(gestion->indice_pokemon, pokemon_nombre(caja_obtener_pokemon(caja, i)))){
			if((strcmp(clave_lista, lista_ultimo(hash_obtener(gestion->indice_pokemon, pokemon_nombre(caja_obtener_pokemon(caja, i)))))) != 0){
				lista_insertar(hash_obtener(gestion->indice_pokemon, pokemon_nombre(caja_obtener_pokemon(caja, i))), (void*)clave_lista);
			}
		} else{
			lista_t *lista = lista_crear();
			if(!lista){
				return;
			}
			lista_insertar(lista, (void*)clave_lista);
			hash_insertar(gestion->indice_pokemon, pokemon_nombre(caja_obtener_pokemon(caja, i)), lista, NULL);
		}
	}
}

gestion_cajas_t *cargar_cajas(int argc, char *argv[])
{	
	gestion_cajas_t *nueva_gestion = malloc(sizeof(gestion_cajas_t));
	if(!nueva_gestion){
		return NULL;
	}
	nueva_gestion->hash_cajas = hash_crear(0);
	nueva_gestion->indice_pokemon = hash_crear(0);
	nueva_gestion->lista_cajas = lista_crear();
	if(!nueva_gestion->hash_cajas || !nueva_gestion->indice_pokemon || !nueva_gestion->lista_cajas){
		return NULL;
	}

	int i = 1;
	while(i < argc){
		caja_t *nueva_caja = caja_cargar_archivo(argv[i]);
		if(!nueva_caja){
			printf("ERROR: La caja %s no pudo ser cargada\n", argv[i]);
		} else{
			nueva_gestion->hash_cajas = hash_insertar(nueva_gestion->hash_cajas, argv[i], nueva_caja, NULL);
			actualizar_indice(nueva_gestion, nueva_caja, argv[i]);
		}
		i++;
	}
	if(!nueva_gestion->hash_cajas || (hash_cantidad(nueva_gestion->hash_cajas) == 0)){
		salir_del_programa(nueva_gestion);
		return NULL;
	}

	return nueva_gestion;
}

bool imprimir_claves_y_cantidad(const char *clave, void *valor, void *aux)
{
	printf("%s ; %i Pokemones\n", clave, caja_cantidad((caja_t*)valor));
	return true;
}

void mostrar_inventario(gestion_cajas_t *gestion)
{
	hash_con_cada_clave(gestion->hash_cajas, imprimir_claves_y_cantidad, NULL);
}

void cargar_otra_caja(gestion_cajas_t *gestion, const char *nueva_clave)
{
	if(!gestion || !nueva_clave)
		return;

	if(!hash_contiene(gestion->hash_cajas, nueva_clave)){
		caja_t *nueva_caja = caja_cargar_archivo(nueva_clave);
		if(!nueva_caja){
			return;
		}
		gestion->hash_cajas = hash_insertar(gestion->hash_cajas, nueva_clave, nueva_caja, NULL);
		actualizar_indice(gestion, nueva_caja, nueva_clave);
		return;
	}
	printf("No se puede cargar una caja nueva con el mismo nombre que una existente\n");
}

void combinar_cajas(gestion_cajas_t *gestion, const char *nombre_caja1, const char *nombre_caja2, const char *nueva_caja)
{
	if(!gestion || !nombre_caja1 || !nombre_caja2 || !nueva_caja){
		return;
	}
	if(hash_contiene(gestion->hash_cajas, nombre_caja1) && hash_contiene(gestion->hash_cajas, nombre_caja2) && !hash_contiene(gestion->hash_cajas, nueva_caja)){
		caja_t *caja_nueva = caja_combinar((caja_t*)hash_obtener(gestion->hash_cajas, nombre_caja1), (caja_t*)hash_obtener(gestion->hash_cajas, nombre_caja2));
		if(!nueva_caja){
			return;
		}
		gestion->hash_cajas = hash_insertar(gestion->hash_cajas, nueva_caja, caja_nueva, NULL);
		actualizar_indice(gestion, caja_nueva, nueva_caja);
		return;
	}
	printf("La cajas ingresadas no existen o el nombre de la nueva caja ya existe\n");
}

void imprimir_caja(pokemon_t *pokemon)
{
	printf("Nombre: %s. Nivel: %i. Ataque: %i. Defensa: %i\n", pokemon_nombre(pokemon), pokemon_nivel(pokemon), pokemon_ataque(pokemon), pokemon_defensa(pokemon));
}

void mostrar_caja(gestion_cajas_t *gestion, const char *caja_mostrar)
{
	if(!gestion || !caja_mostrar){
		return;
	}

	caja_t *caja = hash_obtener(gestion->hash_cajas, caja_mostrar);
	if(!caja){
		printf("No existe una caja con ese nombre\n");
		return;
	}
	caja_recorrer(caja, imprimir_caja);
}

bool imprimir_lista_cajas(void *nombre_caja, void *aux)
{
	printf("%s\n", (char*)nombre_caja);
	return true;
}

void buscar_caja(gestion_cajas_t *gestion, const char *pokemon)
{
	if(!gestion || !pokemon)
		return;
	if(hash_contiene(gestion->indice_pokemon, pokemon)){
		printf("%u cajas contienen este pokemon:\n", lista_tamanio(hash_obtener(gestion->indice_pokemon, pokemon)));
		lista_con_cada_elemento(hash_obtener(gestion->indice_pokemon, pokemon), imprimir_lista_cajas, NULL);
	} else{
		printf("No hay cajas con ese pokemon\n");
	}
}

void destruir_caja(void *caja)
{
	caja_destruir((caja_t*)caja);
}

void destruir_lista(void *lista)
{
	lista_destruir((lista_t*)lista);
}

void salir_del_programa(gestion_cajas_t *gestion)
{
	if(!gestion)
		return;
	hash_destruir_todo(gestion->hash_cajas, destruir_caja);
	hash_destruir_todo(gestion->indice_pokemon, destruir_lista);
	lista_destruir_todo(gestion->lista_cajas, free);
	free(gestion);
}