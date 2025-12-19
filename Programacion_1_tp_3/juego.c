#include <stdio.h>
#include "papeleo.h"
#include "tp1.h"
#include <stdlib.h>
#include <time.h>

const static int JUGANDO = 0;
const static int GANADO = 1;
const static int INDICE_NIVEL_1 = 0;
const static int INDICE_NIVEL_2 = 1;
const static int INDICE_NIVEL_3 = 2;
const static int NIVEL_2 = 2;
const static int NIVEL_3 = 3;
const static bool SUPERADO = true;
const static bool NO_SUPERADO = false;
const static bool DESACTIVADO = false;
const static int MOVIMIENTOS_NIVEL_2 = 30;
const static int MARTILLOS_NIVEL_2 = 5;
const static int EXTINTORES_NIVEL_2 = 2; 
const static int MOVIMIENTOS_NIVEL_3 = 20;
const static int MARTILLOS_NIVEL_3 = 6;
const static int EXTINTORES_NIVEL_3 = 2;
const static int CONTADOR_INICIAL = 0;


//PRE: Los campos de juego deben estar inicialzados.
//POST: Actualiza los datos del jugador para el NIVEL_2 y el NIVEL_3.
void actualizar_datos_de_jugador(juego_t* juego, int nivel){
	if(nivel == NIVEL_2){
		(*juego).nivel_actual = NIVEL_2;
		(*juego).jugador.posicion.fil = (*juego).niveles[INDICE_NIVEL_2].pos_inicial_jugador.fil;
		(*juego).jugador.posicion.col = (*juego).niveles[INDICE_NIVEL_2].pos_inicial_jugador.col;
		(*juego).jugador.movimientos += MOVIMIENTOS_NIVEL_2;
		if((*juego).personaje_tp1 == JASMIN){
			(*juego).jugador.martillos = MARTILLOS_NIVEL_2 + 1;
		}else{
			(*juego).jugador.martillos = MARTILLOS_NIVEL_2;
		}
		(*juego).jugador.extintores = EXTINTORES_NIVEL_2;
		(*juego).jugador.ahuyenta_randall = DESACTIVADO;
		(*juego).jugador.movimientos_realizados = CONTADOR_INICIAL;		 
	
	}

	if(nivel == NIVEL_3){
		(*juego).nivel_actual = NIVEL_3;
		(*juego).jugador.posicion.fil = (*juego).niveles[INDICE_NIVEL_3].pos_inicial_jugador.fil;
		(*juego).jugador.posicion.col = (*juego).niveles[INDICE_NIVEL_3].pos_inicial_jugador.col;
		(*juego).jugador.movimientos += MOVIMIENTOS_NIVEL_3;
		if((*juego).personaje_tp1 == JASMIN){
			(*juego).jugador.martillos = MARTILLOS_NIVEL_3 + 1;
		}else{
			(*juego).jugador.martillos = MARTILLOS_NIVEL_3;
		}
		(*juego).jugador.extintores = EXTINTORES_NIVEL_3;
		(*juego).jugador.ahuyenta_randall = DESACTIVADO;
		(*juego).jugador.movimientos_realizados = CONTADOR_INICIAL;		 
	}
}

int main(){

	srand((unsigned)time(NULL));
	juego_t juego;
	char personaje_tp1;
	elegir_personaje(&personaje_tp1);
	inicializar_juego(&juego, personaje_tp1);
	bool nivel_1_superado = NO_SUPERADO;
	bool nivel_2_superado = NO_SUPERADO;
	while(estado_juego(juego) == JUGANDO){
		if((estado_nivel(juego.niveles[INDICE_NIVEL_1].papeleos, juego.niveles[INDICE_NIVEL_1].tope_papeleos) == GANADO) && !nivel_1_superado){
			nivel_1_superado = SUPERADO;
			actualizar_datos_de_jugador(&juego, NIVEL_2);
		}
		if((estado_nivel(juego.niveles[INDICE_NIVEL_2].papeleos, juego.niveles[INDICE_NIVEL_2].tope_papeleos) == GANADO) && !nivel_2_superado){
			nivel_2_superado = SUPERADO;
			actualizar_datos_de_jugador(&juego, NIVEL_3);
	
		}
		system("clear");
		imprimir_terreno(juego);
		realizar_jugada(&juego);
	}	
	if(estado_juego(juego) == GANADO){
		system("clear");
		printf("GANASTE\n");
	}else {
		system("clear");
		printf("PERDISTE\n");
	}
	return 0;
}


