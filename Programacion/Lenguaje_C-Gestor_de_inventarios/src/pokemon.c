#include "pokemon.h"
#include <stdlib.h>
#include <stdio.h>

#define MAX_NOMBRE_POKEMON 30
const int DATOS_POKEMON = 4;

struct _pokemon_t {
	char nombre[MAX_NOMBRE_POKEMON];
	int nivel;
	int ataque;
	int defensa;
};

pokemon_t *pokemon_crear_desde_string(char *string)
{
	if(!string)
		return NULL;

	pokemon_t *nuevo_pokemon = malloc(sizeof(pokemon_t));
	if(!nuevo_pokemon)
		return NULL;

	int leidos = sscanf(string,"%[^;];%i;%i;%i", nuevo_pokemon->nombre, &nuevo_pokemon->nivel, &nuevo_pokemon->ataque, &nuevo_pokemon->defensa);	
	
	if(leidos == DATOS_POKEMON)
		return nuevo_pokemon;

	free(nuevo_pokemon);
	return NULL;
}

int pokemon_nivel(pokemon_t *pokemon)
{
	if(!pokemon)
		return 0;

	return pokemon->nivel;
}

int pokemon_ataque(pokemon_t *pokemon)
{
	if(!pokemon)
		return 0;

	return pokemon->ataque;
}

int pokemon_defensa(pokemon_t *pokemon)
{
	if(!pokemon)
		return 0;

	return pokemon->defensa;
}

const char *pokemon_nombre(pokemon_t *pokemon)
{
	if(!pokemon)
		return NULL;

	return pokemon->nombre;
}

void pokemon_destruir(pokemon_t *pokemon)
{
	free(pokemon);	
}
