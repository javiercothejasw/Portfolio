#include "abb.h"
#include <stddef.h>
#include <stdlib.h>

abb_t *abb_crear(abb_comparador comparador)
{
	if(!comparador)
		return NULL;
	abb_t *abb_nuevo = calloc(1, sizeof(abb_t));
	if(abb_nuevo){
		abb_nuevo->comparador = comparador;
	}
	return abb_nuevo;
}

nodo_abb_t *abb_insertar_rec(abb_t *arbol, nodo_abb_t *nodo_actual, void *elemento, bool *insercion_correcta)
{
	if(!nodo_actual){
		nodo_abb_t *nuevo_nodo = calloc(1, sizeof(nodo_abb_t));
		if(nuevo_nodo){
			nuevo_nodo->elemento = elemento;
			(arbol->tamanio)++;
			*insercion_correcta = true;
			return nuevo_nodo;
		} else{
			*insercion_correcta = false;
			return NULL;
		}
	}

	if(arbol->comparador(elemento, nodo_actual->elemento) > 0){
		nodo_actual->derecha = abb_insertar_rec(arbol, nodo_actual->derecha, elemento, insercion_correcta);
	} else{
		nodo_actual->izquierda = abb_insertar_rec(arbol, nodo_actual->izquierda, elemento, insercion_correcta);
	}

	return nodo_actual; 
}


abb_t *abb_insertar(abb_t *arbol, void *elemento)
{
	if(!arbol)
		return NULL;
	bool insercion_correcta = false;
	arbol->nodo_raiz = abb_insertar_rec(arbol, arbol->nodo_raiz, elemento, &insercion_correcta);
	if(!insercion_correcta){
		abb_destruir(arbol);
		return NULL;
	}
	return arbol;
}

nodo_abb_t *buscar_elemento_predecesor_inorden(nodo_abb_t *nodo_actual, void **elemento)
{
	if(!nodo_actual->derecha){
		nodo_abb_t *nodo_aux = NULL;
		if(nodo_actual->izquierda){
			nodo_aux = nodo_actual->izquierda;
		}
		*elemento = nodo_actual->elemento;
		free(nodo_actual);
 		return nodo_aux;
	}
	nodo_actual->derecha = buscar_elemento_predecesor_inorden(nodo_actual->derecha, elemento);

	return nodo_actual;
}

nodo_abb_t *abb_quitar_rec(abb_t *arbol, nodo_abb_t *nodo_actual, void *elemento, bool *encontrado, void **elemento_eliminar)
{
	if(!nodo_actual){
		*encontrado = false;
		return NULL;
	}
	if(arbol->comparador(elemento, nodo_actual->elemento) > 0){
		nodo_actual->derecha = abb_quitar_rec(arbol, nodo_actual->derecha, elemento, encontrado, elemento_eliminar);
	} else{
		if(arbol->comparador(elemento, nodo_actual->elemento) < 0){
			nodo_actual->izquierda = abb_quitar_rec(arbol, nodo_actual->izquierda, elemento, encontrado, elemento_eliminar);
		} else{

			if(!nodo_actual->derecha && !nodo_actual->izquierda){
				(arbol->tamanio)--;
				*encontrado = true;
				*elemento_eliminar = nodo_actual->elemento;
				free(nodo_actual);
				return NULL;
			} else{

				if(nodo_actual->derecha && nodo_actual->izquierda){
					(arbol->tamanio)--;
					*encontrado = true;
					*elemento_eliminar = nodo_actual->elemento;
					void *elemento_predecesor_inorden = NULL;
					nodo_actual->izquierda = buscar_elemento_predecesor_inorden(nodo_actual->izquierda, &elemento_predecesor_inorden);
					nodo_actual->elemento = elemento_predecesor_inorden;
					return nodo_actual;
				} else {
					if(nodo_actual->derecha){
						(arbol->tamanio)--;
						*encontrado = true;
						*elemento_eliminar = nodo_actual->elemento;
						nodo_abb_t *nodo_reemplazar = nodo_actual->derecha;
						free(nodo_actual);
						return nodo_reemplazar;
					} else{
						(arbol->tamanio)--;
						*encontrado = true;
						*elemento_eliminar = nodo_actual->elemento;
						nodo_abb_t *nodo_reemplazar = nodo_actual->izquierda;
						free(nodo_actual);
						return nodo_reemplazar;
					}
				}
			}
		}
	}
	return nodo_actual;
}

void *abb_quitar(abb_t *arbol, void *elemento)
{
	if(!arbol || !arbol->nodo_raiz)
		return NULL;
	bool encontrado = false;
	void *elemento_eliminado = NULL;
	arbol->nodo_raiz = abb_quitar_rec(arbol, arbol->nodo_raiz, elemento, &encontrado, &elemento_eliminado);

	if(encontrado){
		return elemento_eliminado;
	}
	return NULL;
}

void *abb_buscar(abb_t *arbol, void *elemento)
{
	if(!arbol || !arbol->nodo_raiz)
		return NULL;
	nodo_abb_t *nodo_actual = arbol->nodo_raiz;
	while(nodo_actual && (arbol->comparador(elemento, nodo_actual->elemento) != 0)){
		if(arbol->comparador(elemento, nodo_actual->elemento) > 0){
			nodo_actual = nodo_actual->derecha;
		} else {
			if(arbol->comparador(elemento, nodo_actual->elemento) < 0)
			nodo_actual = nodo_actual->izquierda;
		}
	}
	if(nodo_actual)
		return nodo_actual->elemento;
	return NULL;
}

bool abb_vacio(abb_t *arbol)
{
	if(!arbol || !arbol->nodo_raiz)
		return true;
	return false;
}

size_t abb_tamanio(abb_t *arbol)
{
	if(!arbol)
		return 0;
	return arbol->tamanio;
}

void abb_destruir_rec(nodo_abb_t *nodo_actual)
{
	if(!nodo_actual)
		return;
	abb_destruir_rec(nodo_actual->izquierda);
	abb_destruir_rec(nodo_actual->derecha);

	free(nodo_actual);
}

void abb_destruir(abb_t *arbol)
{
	if(!arbol)
		return;
	abb_destruir_rec(arbol->nodo_raiz);
	free(arbol);
}

void abb_destruir_todo_rec(nodo_abb_t *nodo_actual, void (*destructor)(void *))
{
	if(!nodo_actual)
		return;
	abb_destruir_todo_rec(nodo_actual->izquierda, destructor);
	abb_destruir_todo_rec(nodo_actual->derecha, destructor);

	if(destructor)
		destructor(nodo_actual->elemento);

	free(nodo_actual);	
}

void abb_destruir_todo(abb_t *arbol, void (*destructor)(void *))
{
	if(!arbol)
		return;
	abb_destruir_todo_rec(arbol->nodo_raiz, destructor);
	free(arbol);
}

size_t abb_con_cada_elemento_inorden_rec(nodo_abb_t *nodo_actual, bool (*funcion)(void *, void *), void *aux, bool *condicion_de_corte)
{
	if(!nodo_actual)
		return 0;
	size_t contador = 0;
	if(*condicion_de_corte){
		contador += abb_con_cada_elemento_inorden_rec(nodo_actual->izquierda, funcion, aux, condicion_de_corte);

		if(*condicion_de_corte){
			if(funcion(nodo_actual->elemento, aux)){
				contador += 1;
			} else{
				*condicion_de_corte = false;
				contador += 1;
			}
		}
		contador += abb_con_cada_elemento_inorden_rec(nodo_actual->derecha, funcion, aux, condicion_de_corte);
	}
	return contador;
}

size_t abb_con_cada_elemento_preorden_rec(nodo_abb_t *nodo_actual, bool (*funcion)(void *, void *), void *aux, bool *condicion_de_corte)
{
	if(!nodo_actual)
		return 0;
	size_t contador = 0;
	if(*condicion_de_corte){
		if(funcion(nodo_actual->elemento, aux)){
			contador += 1;
		} else{
			*condicion_de_corte = false;
			contador += 1;;
		}
		contador += abb_con_cada_elemento_preorden_rec(nodo_actual->izquierda, funcion, aux, condicion_de_corte);
		contador += abb_con_cada_elemento_preorden_rec(nodo_actual->derecha, funcion, aux, condicion_de_corte);
	}
	return contador;
}

size_t abb_con_cada_elemento_postorden_rec(nodo_abb_t *nodo_actual, bool (*funcion)(void *, void *), void *aux, bool *condicion_de_corte)
{
	if(!nodo_actual)
		return 0;
	size_t contador = 0;
	if(condicion_de_corte){
		contador += abb_con_cada_elemento_postorden_rec(nodo_actual->izquierda, funcion, aux, condicion_de_corte);

		contador += abb_con_cada_elemento_postorden_rec(nodo_actual->derecha, funcion, aux, condicion_de_corte);

		if(*condicion_de_corte){
			if(funcion(nodo_actual->elemento, aux)){
				contador += 1;
			} else{
				*condicion_de_corte = false;
				contador += 1;
			}
		}
	}
	return contador;
}

size_t abb_con_cada_elemento(abb_t *arbol, abb_recorrido recorrido,
			     bool (*funcion)(void *, void *), void *aux)
{
	if(!arbol || !funcion)
		return 0;
	if(recorrido == 0){
		bool condicion_de_corte = true;
		return abb_con_cada_elemento_inorden_rec(arbol->nodo_raiz, funcion, aux, &condicion_de_corte);
	}
	if(recorrido == 1){
		bool condicion_de_corte = true;
		return abb_con_cada_elemento_preorden_rec(arbol->nodo_raiz, funcion, aux, &condicion_de_corte);
	}
	if(recorrido == 2){
		bool condicion_de_corte = true;
		return abb_con_cada_elemento_postorden_rec(arbol->nodo_raiz, funcion, aux, &condicion_de_corte);
	}
	return 0;
}

void abb_recorrer_inorden(nodo_abb_t *nodo_actual, void **array, size_t tamanio_array, size_t *contador_array)
{
	if(!nodo_actual)
		return;
	if(*contador_array < tamanio_array){
		abb_recorrer_inorden(nodo_actual->izquierda, array, tamanio_array, contador_array);
		
		if(*contador_array < tamanio_array){
			array[*contador_array] = nodo_actual->elemento;
			(*contador_array)++;
		}

		abb_recorrer_inorden(nodo_actual->derecha, array, tamanio_array, contador_array);
	}
	return;
}

void abb_recorrer_preorden(nodo_abb_t *nodo_actual, void **array, size_t tamanio_array, size_t *contador_array)
{
	if(!nodo_actual)
		return;
	if(*contador_array < tamanio_array){

		if(*contador_array < tamanio_array){
			array[*contador_array] = nodo_actual->elemento;
			(*contador_array)++;
		}

		abb_recorrer_preorden(nodo_actual->izquierda, array, tamanio_array, contador_array);

		abb_recorrer_preorden(nodo_actual->derecha, array, tamanio_array, contador_array);
	}
	return;
}

void abb_recorrer_postorden(nodo_abb_t *nodo_actual, void **array, size_t tamanio_array, size_t *contador_array)
{
	if(!nodo_actual)
		return;
	if(*contador_array < tamanio_array){
		
		abb_recorrer_postorden(nodo_actual->izquierda, array, tamanio_array, contador_array);

		abb_recorrer_postorden(nodo_actual->derecha, array, tamanio_array, contador_array);

		if(*contador_array < tamanio_array){
			array[*contador_array] = nodo_actual->elemento;
			(*contador_array)++;
		}
	}
	return;
}

size_t abb_recorrer(abb_t *arbol, abb_recorrido recorrido, void **array,
		    size_t tamanio_array)
{
	if(!arbol)
		return 0;
	if(recorrido == 0){
		size_t contador_array = 0;
		abb_recorrer_inorden(arbol->nodo_raiz, array, tamanio_array, &contador_array);
		return contador_array;
	}
	if(recorrido == 1){
		size_t contador_array = 0;
		abb_recorrer_preorden(arbol->nodo_raiz, array, tamanio_array, &contador_array);
		return contador_array;
	}
	if(recorrido == 2){
		size_t contador_array = 0;
		abb_recorrer_postorden(arbol->nodo_raiz, array, tamanio_array, &contador_array);
		return contador_array;
	}
	return 0;
}
