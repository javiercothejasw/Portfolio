#include "lista.h"
#include <stddef.h>
#include <stdlib.h>

lista_t *lista_crear()
{
	lista_t *nueva_lista = (lista_t*)malloc(sizeof(lista_t));
	if(!nueva_lista)
		return NULL;
	nueva_lista->nodo_inicio = NULL;
	nueva_lista->nodo_fin = NULL;
	nueva_lista->cantidad = 0;
	return nueva_lista;
}

lista_t *lista_insertar(lista_t *lista, void *elemento)
{
	if(!lista)
		return NULL;
	if(lista->cantidad == 0){
		lista->nodo_inicio = (nodo_t*)malloc(sizeof(nodo_t));
		if(!lista->nodo_inicio)
			return NULL;
		lista->nodo_inicio->elemento = elemento;
		lista->nodo_inicio->siguiente = NULL;
		lista->nodo_fin = lista->nodo_inicio;
		(lista->cantidad)++;
		return lista;	
	}
	nodo_t *nuevo_nodo = (nodo_t*)malloc(sizeof(nodo_t));
	if(!nuevo_nodo)
		return NULL;
	nuevo_nodo->elemento = elemento;
	nuevo_nodo->siguiente = NULL;
	lista->nodo_fin->siguiente = nuevo_nodo;
	lista->nodo_fin = nuevo_nodo;
	(lista->cantidad)++;
	return lista;
}

lista_t *lista_insertar_en_posicion(lista_t *lista, void *elemento,
				    size_t posicion)
{
	if(!lista)
		return NULL;
	if(!lista->nodo_inicio){
		lista_insertar(lista, elemento);
		return lista;
	}
	nodo_t *nuevo_nodo = (nodo_t*)malloc(sizeof(nodo_t));
	if(!nuevo_nodo)
		return NULL;
	nuevo_nodo->elemento = elemento;
	if(posicion == 0){
		nuevo_nodo->siguiente = lista->nodo_inicio;
		lista->nodo_inicio = nuevo_nodo;
		(lista->cantidad)++;
		return lista;
	}
	int i = 1;
	nodo_t *nodo_actual = lista->nodo_inicio;
	while(i < lista->cantidad && i < posicion){
		nodo_actual = nodo_actual->siguiente;
		i++;
	}
	nuevo_nodo->siguiente = nodo_actual->siguiente;
	nodo_actual->siguiente = nuevo_nodo;
	if(i == lista->cantidad)
		lista->nodo_fin = nuevo_nodo;
	lista->nodo_fin->siguiente = NULL;
	(lista->cantidad)++;

	return lista;
}

void *lista_quitar(lista_t *lista)
{
	if(!lista || lista->cantidad == 0)
		return NULL;
	int i = 2;
	nodo_t *nodo_actual = lista->nodo_inicio;
	while(i < lista->cantidad){
		nodo_actual = nodo_actual->siguiente;
		i++;
	}
	void *elemento = lista->nodo_fin->elemento; 
	free(lista->nodo_fin);
	lista->nodo_fin = nodo_actual;
	(lista->cantidad)--;
	if(lista->cantidad > 0)
		lista->nodo_fin->siguiente = NULL;
	if(lista->cantidad == 0){
		lista->nodo_inicio = NULL;
		lista->nodo_fin = NULL;
	}

	return elemento;
}

void *lista_quitar_de_posicion(lista_t *lista, size_t posicion)
{
	if(!lista || lista->cantidad == 0)
		return NULL;
	void *elemento;
	int i = 0;
	nodo_t *nodo_quitar_anterior = lista->nodo_inicio;
	nodo_t *nodo_quitar = lista->nodo_inicio;
	while( i < posicion && i < (lista->cantidad -1)){
		nodo_quitar_anterior = nodo_quitar;
		nodo_quitar = nodo_quitar->siguiente;
		i++;
	}
	elemento = nodo_quitar->elemento;
	nodo_quitar_anterior->siguiente = nodo_quitar->siguiente;
	if(i == 0)
		lista->nodo_inicio = lista->nodo_inicio->siguiente;
	if(i == (lista->cantidad -1))
		lista->nodo_fin = nodo_quitar_anterior;
	free(nodo_quitar);
	(lista->cantidad)--;
	if(lista->cantidad == 0){
		lista->nodo_inicio = NULL;
		lista->nodo_fin = NULL;
	}

	return elemento;
}

void *lista_elemento_en_posicion(lista_t *lista, size_t posicion)
{
	if(!lista || posicion >= lista->cantidad || (int)posicion < 0)
		return NULL;
	nodo_t *nodo_actual = lista->nodo_inicio;
	int i = 0;
	while(i < posicion){
		nodo_actual = nodo_actual->siguiente;
		i++;
	}

	return nodo_actual->elemento;
}

void *lista_buscar_elemento(lista_t *lista, int (*comparador)(void *, void *),
			    void *contexto)
{
	if(!lista || lista->cantidad == 0 || !comparador)
		return NULL;
	nodo_t *nodo_actual = lista->nodo_inicio;
	while(nodo_actual->siguiente && !(comparador(nodo_actual->elemento, contexto) == 0)){
		nodo_actual = nodo_actual->siguiente;
	}
	if(comparador(nodo_actual->elemento, contexto) == 0)
		return nodo_actual->elemento;
	return NULL;
}

void *lista_primero(lista_t *lista)
{
	if(!lista || lista->cantidad == 0)
		return NULL;
	return lista->nodo_inicio->elemento;
}

void *lista_ultimo(lista_t *lista)
{
	if(!lista || lista->cantidad == 0)
		return NULL;
	return lista->nodo_fin->elemento;
}

bool lista_vacia(lista_t *lista)
{
	return (!lista || lista->cantidad == 0);
}

size_t lista_tamanio(lista_t *lista)
{
	if(!lista)
		return 0;
	return lista->cantidad;
}

void lista_destruir(lista_t *lista)
{
	if(!lista)
		return;
	nodo_t *nodo_actual = lista->nodo_inicio;
	nodo_t *nodo_borrar;
	while(nodo_actual != NULL){
		nodo_borrar = nodo_actual;
		nodo_actual = nodo_actual->siguiente;
		free(nodo_borrar);
	}
	free(lista);
}

void lista_destruir_todo(lista_t *lista, void (*funcion)(void *))
{
	if(!lista)
		return;
	nodo_t *nodo_actual = lista->nodo_inicio;
	nodo_t *nodo_borrar;
	while(nodo_actual){
		nodo_borrar = nodo_actual;
		nodo_actual = nodo_actual->siguiente;
		if(funcion)
			funcion(nodo_borrar->elemento);
		free(nodo_borrar);
	}
	free(lista);
}

lista_iterador_t *lista_iterador_crear(lista_t *lista)
{
	if(!lista)
		return NULL;
	lista_iterador_t *iterador = (lista_iterador_t*)malloc(sizeof(lista_iterador_t));
	iterador->corriente = lista->nodo_inicio;
	iterador->lista = lista;
	return iterador;
}

bool lista_iterador_tiene_siguiente(lista_iterador_t *iterador)
{
	if(!iterador || iterador->lista->cantidad == 0)
		return false;
	return (iterador->corriente != NULL);
}

bool lista_iterador_avanzar(lista_iterador_t *iterador)
{
	if(!iterador || iterador->lista->cantidad == 0)
		return false;
	iterador->corriente = iterador->corriente->siguiente;
	return (iterador->corriente != NULL);
}

void *lista_iterador_elemento_actual(lista_iterador_t *iterador)
{
	if(!iterador || !iterador->corriente)
		return NULL;
	return iterador->corriente->elemento;
}

void lista_iterador_destruir(lista_iterador_t *iterador)
{
	free(iterador);
}

size_t lista_con_cada_elemento(lista_t *lista, bool (*funcion)(void *, void *),
			       void *contexto)
{
	if(!lista || !funcion || lista->cantidad == 0)
		return 0;
	size_t i = 1;
	nodo_t *nodo_actual = lista->nodo_inicio;
	while(funcion(nodo_actual->elemento, contexto) && nodo_actual->siguiente){
		nodo_actual = nodo_actual->siguiente;
		i++;
	}
	return i;
}
