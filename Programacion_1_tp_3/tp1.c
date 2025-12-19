#include <stdio.h>
#include "tp1.h"

const char TRANSPORTE_1 = 'T';
const char TRANSPORTE_2 = 'N';
const char TRANSPORTE_3 = 'C';
const char TRANSPORTE_4 = 'A';

const char MEDIO_ESCAPE_1 = 'B';
const char MEDIO_ESCAPE_2 = 'P';
const char MEDIO_ESCAPE_3 = 'K';
const char MEDIO_ESCAPE_4 = 'G';

const int HORA_MINIMA = 0;
const int HORA_MAXIMA = 24;
const float MINUTOS_MINIMO = 0;
const float MINUTOS_MAXIMO = 0.60f;

const int NOTA_MINIMA = 1;
const int NOTA_MAXIMA = 10;

const int PUNTAJE_1_PREGUNTA_1 = 10;
const int PUNTAJE_2_PREGUNTA_1 = 20;

const int PUNTAJE_1_PREGUNTA_2 = 3;
const int PUNTAJE_2_PREGUNTA_2 = 6;
const int PUNTAJE_3_PREGUNTA_2 = 9;
const int PUNTAJE_4_PREGUNTA_2 = 12;

const int PUNTAJE_1_PREGUNTA_4 = 1;
const int PUNTAJE_2_PREGUNTA_4 = 2;
const int PUNTAJE_3_PREGUNTA_4 = 3;
const int PUNTAJE_4_PREGUNTA_4 = 4;

const int COTA_1_NOTA = 3;
const int COTA_2_NOTA = 4;
const int COTA_3_NOTA = 6;
const int COTA_4_NOTA = 7;
const int COTA_5_NOTA = 8;

const int COTA_PUNTAJE = 41;
const float HORA_EXAMEN = 15.30f;

//PRE: no tiene
//POST: Imprime un mensaje por pantalla.
void bienvenida(){
	printf("BIENVENIDO/A!!\n\n" 
		   
		   "En este cuestionario te realizaremos algunas preguntas y en base\n"
		   "a tus respuestas depterminaremos que personaje de DISNEY es el\n"
		   "que mas se adapta a tu personalidad.\n\n"

		   "Tus opciones son: *OLAF* *STITCH* *JASMIN* *RAYO MCQUEEN*\n\n"

		   "¡¡COMENZEMOS!!\n\n"

		   "Vas a tener que dar uno de los finales mas dificiles de tu vida,\n"
		   "te preparaste incansablemente para dar bien este examen. Pero cuando\n"
		   "llega el dia de rendir el final te encontras con este titulo en las\n"
		   "noticias: PARO TOTAL DE TODOS LOS TRANSPORTES.\n"
		   "Dada esta situacion a lo unico que podes recurrir es a la ayuda de tus\n"
		   "amiguitos de DISNEY.\n"
		   "Ahora con los amigos de DISNEY a tu dispocicion:\n\n");

}

//PRE: no tiene
//POST:Garantiza la entrada de un caracter valido(TRANSPORTE_1, TRANSPORTE_2,
//TRANSPORTE_3, TRANSPORTE_4)
void elegir_transporte(char* eleccion_transporte){

	printf("\n1.¿Que otro transporte elegis?\n"
		   "(la respuesta puede ser: Trineo(T), Nave Espacial(N), Camion(C)\n"
		   "o Alfombra(A)\n");
	scanf(" %c", eleccion_transporte);
	while( *eleccion_transporte != TRANSPORTE_1 && *eleccion_transporte != TRANSPORTE_2 
			&& *eleccion_transporte != TRANSPORTE_3 && *eleccion_transporte != TRANSPORTE_4){

		printf("\nEse transporte no es de DISNEY, por favor elige uno\n"
			   "de los tranportes disponibles(T,N,C,A)\n");
		scanf(" %c", eleccion_transporte);
	}
}
//PRE: no tiene
//POST: Garantiza la obtencion de un caracter valido(MEDIO_ESCAPE_1, MEDIO_ESCAPE_2,
//MEDIO_ESCAPE_3, MEDIO_SECAPE_4)
void elegir_escape(char* eleccion_escape){

	printf("\n2. En medio del camino te contras con una manifestacion\n"
		   "¿Que medio utilizas para deshacerte de la minifestacion?\n"
		   "(la respuesta puede ser: Bolas de nieve(B), Pium pium(P)),\n"
		   "Kuchau(K) o Genio(G)\n");
	scanf(" %c", eleccion_escape);
	while(*eleccion_escape != MEDIO_ESCAPE_1 && *eleccion_escape != MEDIO_ESCAPE_2 &&
		  *eleccion_escape != MEDIO_ESCAPE_3 && *eleccion_escape != MEDIO_ESCAPE_4 ){
		printf("\nCon eso no podras atravesar la manifestacion!! El examen te espera!!\n"
			   "Rapido, elegi algo que te ayude(B,P,K,G)\n");
		scanf(" %c", eleccion_escape);

	}

}
//PRE: no tiene
//POST: Garantiza la obtencion de un valor decimal, tal que, la parte
//entera esta comprendida entre HORA_MINIMA y HORA_MAXIMA, y la parte
//decimal esta comprendida entre MINUTOS_MINIMO y menor a MINUTOS_MAXIMO. 
void elegir_hora(float* hora_llegada){

	printf("\n3. Lograste superar la manifestacion, teniendo en cuenta que tu examen\n"
		   "es a las 15:30 horas ¿A que hora conseguiste llegar a la Universidad?\n"
		   "(la respuesta debe ser del tipo: xx.zz, donde xx es la hora(0 a 23) \n" 
		   "y zz los minutos(00 a 59)\n");
	scanf("%f", hora_llegada);

	int horas = (int) *hora_llegada;
	float minutos = *hora_llegada - (float) horas;

	while( *hora_llegada < HORA_MINIMA || *hora_llegada >= HORA_MAXIMA ||
			minutos < MINUTOS_MINIMO || minutos >= MINUTOS_MAXIMO){

		printf("\nTal vez en el planeta origen de Stitch exista ese uso horario,\n"
			   "pero aca en la Tierra no, por favor elegi una hora del planeta Tierra.\n"
			   "((xx.zz) xx = horas, zz = minutos)\n");
		scanf("%f", hora_llegada);

		horas = (int) *hora_llegada;
		minutos = *hora_llegada - (float) horas;
	}	

}

//PRE: no tiene
//POST: Garantiza la obtencion de un valor comprendido entre NOTA_MINIMA
//y NOTA_MAXIMA.
void elegir_nota(int* nota_final){

	printf("\n4. Por fin llego la nota del parcial ¿Que nota lograste sacar?(1-10)\n");
	scanf("%i", nota_final);

	while(*nota_final < NOTA_MINIMA || *nota_final > NOTA_MAXIMA){
		if (*nota_final < NOTA_MINIMA){

			printf("\nVamos, no creo que lo hayas hecho tan mal...\n"
				   "(la calificacion debe estar entre 1 y 10)\n");
			scanf("%i", nota_final);

		}else {
			printf("\nEsa nota podria ser una SUPER 'A', pero en tu facultad\n"
				   "solo califican del 1 al 10, por favor ingresa otra nota.\n");
			scanf("%i", nota_final);
		}

	}

}
//PRE: no tiene
//POST: Devuelve un valor igual a PUNTAJE_1_PREGUNTA_1
//o igual a PUNTAJE_2_PREGUNTA_1;
int valor_1(char eleccion_transporte){

	if(eleccion_transporte == TRANSPORTE_1 || eleccion_transporte == TRANSPORTE_2){

		return PUNTAJE_1_PREGUNTA_1;
	}else {

		return PUNTAJE_2_PREGUNTA_1;
	}
}
//PRE: no tiene
//POST: Devuelve un valor igual a PUNTAJE_1_PREGUNTA_2, PUNTAJE_2_PREGUNTA_2,
//PUNTAJE_3_PREGUNTA_2, PUNTAJE_4_PREGUNTA_2 o 0.
int valor_2(char eleccion_escape){

	switch(eleccion_escape){

		case 'B': return PUNTAJE_1_PREGUNTA_2;
		break;
		case 'P': return PUNTAJE_2_PREGUNTA_2;
		break;
		case 'K': return PUNTAJE_3_PREGUNTA_2;
		break;
		case 'G': return PUNTAJE_4_PREGUNTA_2;
	}
	return 0;
}
//PRE: no tiene
//POST: Devuelce un valor igual a PUNTAJE_1_PREGUNTA_4, PUNTAJE_2_PREGUNTA_2,
//PUNTAJE_3_PREGUNTA_4 o PUNTAJE_4_PREGUNTA_4.
int valor_4(int nota_final){

	if(nota_final <= COTA_1_NOTA){
		return PUNTAJE_1_PREGUNTA_4;
	}else{
		if(nota_final >= COTA_2_NOTA && nota_final <= COTA_3_NOTA){
			return PUNTAJE_2_PREGUNTA_4;
		} else{
			if(nota_final >= COTA_4_NOTA && nota_final <= COTA_5_NOTA){
				return PUNTAJE_3_PREGUNTA_4;
			} else {
				return PUNTAJE_4_PREGUNTA_4;
			}

		}
	}
}
//PRE: no tiene
//POST: Imprime un mensaje por pantalla mostrando el valor de "puntaje".
void asignar_personaje(char eleccion_transporte, char eleccion_escape, 
						float hora_llegada, int nota_final,char* personaje){

	int puntaje = valor_1(eleccion_transporte) + 
	(valor_2(eleccion_escape) * valor_4(nota_final));

	if(puntaje <= COTA_PUNTAJE){
		if(hora_llegada <= HORA_EXAMEN){
			printf("\nFelicidades tu puntaje fue de %i. \n"
				   "Tu personaje es -Stitch- !! El experimento 626\n"
				   "Gran personalidad la del amigo azulado.\n", puntaje);
			*personaje = STITCH;
		} else{
			printf("\nFelicidades tu puntaje fue de %i. \n"
				   "Por lo que tu personaje es -Olaf-\n"
				   "Mejor suerte para la proxima...\n", puntaje);
			*personaje = OLAF;
		}
	} else{
		if(hora_llegada <= HORA_EXAMEN){
			printf("\nFelicidades tu puntaje fue de %i \n"
				   "Y tu personaje es -Jasmín- !!\n"
				   "Una princesa valiente y audaz.\n", puntaje);
			*personaje = JASMIN;
		} else{
			printf("\nFelicidades tu puntaje fue de %i \n"
				   "Y tu personaje es el -Rayo McQueen-\n"
				   "KUCHAU!!\n", puntaje);
			*personaje = RAYO_MCQUEEN;
		}
	}

}

void elegir_personaje(char* personaje){

	char eleccion_transporte;
	char eleccion_escape;
	float hora_llegada;
	int nota_final;
	bienvenida();
	elegir_transporte(&eleccion_transporte);
	elegir_escape(&eleccion_escape);
	elegir_hora(&hora_llegada);
	elegir_nota(&nota_final);
	asignar_personaje(eleccion_transporte, eleccion_escape,
	hora_llegada, nota_final, *(&personaje));
}