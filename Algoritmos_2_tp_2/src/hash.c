#include "hash.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct par{
	char *clave;
	void *valor;
	struct par *siguiente;

}par_t;

struct hash {
	par_t **pares;
	size_t capacidad;
	size_t ocupados;
};

hash_t *hash_crear(size_t capacidad)
{
	if(capacidad < 3)
		capacidad = 3;

	hash_t *hash_nuevo = malloc(sizeof(hash_t));
	if(!hash_nuevo)
		return NULL;
	hash_nuevo->capacidad = capacidad;
	hash_nuevo->ocupados = 0;
	hash_nuevo->pares = calloc(capacidad, sizeof(par_t*));
	if(!hash_nuevo->pares){
		free(hash_nuevo);
		hash_nuevo = NULL;
	}

	return hash_nuevo;
}	

size_t funcion_hash(const char *string)
{
	size_t hash = 5381;
	int c;

	while((c = *(string++)))
		hash = ((hash << 5) + hash) + (size_t)c;

	return hash;
}

par_t *insertar_rehash(par_t *par, par_t *par_insertar)
{
	if(!par){
		par = par_insertar;
		par->siguiente = NULL;
		return par;
	}
	par->siguiente = insertar_rehash(par->siguiente, par_insertar);

	return par;
}

hash_t *rehash(hash_t *hash)
{
	size_t nueva_capacidad = hash->capacidad * 2;
	par_t **pares_nuevo = calloc(nueva_capacidad, sizeof(par_t*));
	if(!pares_nuevo)
		return NULL;

	size_t posicion = 0;
	par_t *par_aux = NULL;
	par_t *par_siguiente = NULL;
	for(size_t i = 0; i < hash->capacidad; i++){
		par_aux = hash->pares[i]; 
		while(par_aux){
			par_siguiente = par_aux->siguiente;
			posicion = funcion_hash(par_aux->clave)%nueva_capacidad;
			pares_nuevo[posicion] = insertar_rehash(pares_nuevo[posicion], par_aux);
			par_aux = par_siguiente; 
		}
	}
	hash->capacidad = nueva_capacidad;
	par_t **pares_aux = hash->pares;
	hash->pares = pares_nuevo;
	pares_nuevo = pares_aux;
	free(pares_nuevo);

	return hash;
}


par_t *insertar_rec(hash_t *hash, par_t *par, const char *clave, void *elemento, void **anterior, bool *insertado_correcto)
{
	if(!par){
		par_t *par_nuevo = calloc(1, sizeof(par_t));
		if(par_nuevo){
			par_nuevo->clave = malloc(strlen(clave) + 1);
			if(par_nuevo->clave){
				strcpy(par_nuevo->clave, clave);
			} else {
				*insertado_correcto = false;
				return NULL;
			}
			par_nuevo->valor = elemento;
			par_nuevo->siguiente = NULL;
			if(anterior)
				*anterior = NULL;
			*insertado_correcto = true;
			(hash->ocupados)++;
		}else {
			*insertado_correcto = false;
		}
		return par_nuevo;
	}

	if(strcmp(par->clave, clave) == 0){
		if(anterior)
			*anterior = par->valor;

		par->valor = elemento;
		*insertado_correcto = true;
		return par;
	}

	par->siguiente = insertar_rec(hash, par->siguiente, clave, elemento, anterior, insertado_correcto);

	return par;
}

hash_t *hash_insertar(hash_t *hash, const char *clave, void *elemento,
		      void **anterior)
{
	if(!hash || !clave)
		return NULL;
	
	size_t ubicacion = funcion_hash(clave)%hash->capacidad;

	bool insertado_correcto = false;
	hash->pares[ubicacion] = insertar_rec(hash, hash->pares[ubicacion], clave, elemento, anterior, &insertado_correcto);

	if(hash->ocupados >= (hash->capacidad * 0.70)){
		hash = rehash(hash);
	}

	if(!insertado_correcto)
		hash = NULL;
	
	return hash;
}

par_t *hash_quitar_rec(hash_t *hash, par_t *par, const char *clave, void **elemento)
{
	if(!par){
		*elemento = NULL;	
		return NULL;
	}

	if(strcmp(par->clave, clave) == 0){
		par_t *aux = par->siguiente;	
		free(par->clave);
		*elemento = par->valor;
		free(par);
		(hash->ocupados)--;
		return aux;
	}

	par->siguiente = hash_quitar_rec(hash, par->siguiente, clave, elemento);

	return par;
}

void *hash_quitar(hash_t *hash, const char *clave)
{
	if(!hash || !clave)
		return NULL;
	size_t posicion = funcion_hash(clave)%hash->capacidad;
	void *elemento = NULL;
	hash->pares[posicion] = hash_quitar_rec(hash, hash->pares[posicion], clave, &elemento);

	return elemento;
}

void *hash_obtener(hash_t *hash, const char *clave)
{
	if(!hash || !clave)
		return NULL;

	size_t posicion = funcion_hash(clave)%hash->capacidad;
	par_t *aux = hash->pares[posicion];
	while(aux && (strcmp(aux->clave,clave) != 0)){
		aux = aux->siguiente;
	}
	void *elemento = NULL;
	if(aux)
		elemento = aux->valor;

	return elemento; 
}

bool hash_contiene(hash_t *hash, const char *clave)
{
	if(!hash || !clave)
		return false;
	size_t posicion = funcion_hash(clave)%hash->capacidad;
	par_t *aux = hash->pares[posicion];
	while(aux && (strcmp(aux->clave,clave) != 0)){
		aux = aux->siguiente;
	}
	bool encontrado = false;
	if(aux)
		encontrado = true;

	return encontrado; 

}

size_t hash_cantidad(hash_t *hash)
{
	if(!hash)
		return 0;
	return hash->ocupados;
}

void hash_destruir_rec(par_t *par)
{
	if(!par)
		return;
	hash_destruir_rec(par->siguiente);
	free(par->clave);
	free(par);
}

void hash_destruir(hash_t *hash)
{
	if(!hash)
		return;
	for(size_t i = 0; i < hash->capacidad; i++){ 
		
		hash_destruir_rec(hash->pares[i]);
	}
	free(hash->pares);
	free(hash);
}

void hash_destruir_todo_rec(par_t *par, void (*destructor)(void *))
{
	if(!par)
		return;
	hash_destruir_todo_rec(par->siguiente, destructor);
	free(par->clave);
	if(destructor)
		destructor(par->valor);

	free(par);
}

void hash_destruir_todo(hash_t *hash, void (*destructor)(void *))
{
	if(!hash)
		return;
	for(size_t i = 0; i < hash->capacidad; i++){ 
		
		hash_destruir_todo_rec(hash->pares[i], destructor);
	}
	free(hash->pares);
	free(hash);
}

size_t hash_con_cada_clave_rec(bool (*f)(const char *clave, void *valor, void *aux), par_t *par, void *aux, bool *condicion)
{
	if(!par)
		return 0;
	if(f(par->clave, par->valor, aux)){
		return 1 + hash_con_cada_clave_rec(f, par->siguiente, aux, condicion);
	} else{
		*condicion = false;
	}
	return 1;
}

size_t hash_con_cada_clave(hash_t *hash,
			   bool (*f)(const char *clave, void *valor, void *aux),
			   void *aux)
{
	if(!hash || !f)
		return 0;
	bool condicion = true;
	size_t contador = 0;
	size_t i = 0;
	while(i < hash->capacidad && condicion){
		contador += hash_con_cada_clave_rec(f, hash->pares[i], aux, &condicion);
		i++;
	}

	return contador;
}
