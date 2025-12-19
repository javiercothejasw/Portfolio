#include "papeleo.h"
#include "tp1.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

const int OBSTACULOS_NIVEL1 = 15;
const int MEDIAS_NIVEL1 = 5;
const int HERRAMIENTAS_NIVEL1 = 5;
const int BOTELLA_GRITOS_NIVEL1 = 4;
const int PAPELEOS_NIVEL1 = 2;
const int MOVIMIENTOS_NIVEL1 = 40;
const int MARTILLOS_NIVEL1 = 4;
const int EXTINTORES_NIVEL1 = 4;

const int OBSTACULOS_NIVEL2 = 9;
const int MEDIAS_NIVEL2 = 4;
const int HERRAMIENTAS_NIVEL2 = 4;
const int BOTELLA_GRITOS_NIVEL2 = 3;
const int PAPELEOS_NIVEL2 = 3;
const int MOVIMIENTOS_NIVEL2 = 30;
const int MARTILLOS_NIVEL2 = 5;
const int EXTINTORES_NIVEL2 = 2;

const int OBSTACULOS_NIVEL3 = 6;
const int MEDIAS_NIVEL3 = 3;
const int HERRAMIENTAS_NIVEL3 = 2;
const int PAPELEOS_NIVEL3 = 4;
const int MOVIMIENTOS_NIVEL3 = 20;
const int MARTILLOS_NIVEL3 = 6;
const int EXTINTORES_NIVEL3 = 2;

const char MEDIAS = 'M';
const char FUEGOS = 'F';
const char BOTELLA_GRITOS = 'G';
const char INTERRUPTORES = 'I';
const char WAZOWSKI = 'W';
const bool DESACTIVADO = false;

const int DISTANCIA_PAREDES = 1;
#define MAX_CAMPOS_NIVEL1 22
#define MAX_CAMPOS_NIVEL2 17
#define MAX_CAMPOS_NIVEL3 12
const int INDICE_NIVEL1 = 0;
const int INDICE_NIVEL2 = 1;
const int INDICE_NIVEL3 = 2; 

const int NIVEL1 = 1;
const int NIVEL2 = 2;
const int NIVEL3 = 3;
const int NIVEL_ACTUAL = 1;

const char PARED = '|';
const int ASCII_0 = 48;
const char CAMPO_VACIO = (char)32;

const char DIRECCION_DERECHA = 'D';
const char DIRECCION_IZQUIERDA = 'A';
const char DIRECCION_ARRIBA = 'W';
const char DIRECCION_ABAJO = 'S';
const char USAR_MARTILLO = 'Z';
const char USAR_EXTINTOR = 'C';
const char ROTAR_HORARIO = 'E';
const char ROTAR_ANTIHORARIO = 'Q';

const int MOVIMIENTOS_PERDIDOS_POR_MEDIA = 10; 
const int MOVIMIENTOS_GANADOS_POR_BOTELLA = 7;
const int DIVISOR_DE_MOVIMIENTOS_REALIZADOS_NIVEL1 = 7;
const int DIVISOR_DE_MOVIMIENTOS_REALIZADOS_NIVEL2 = 5;
const int DIVISOR_DE_MOVIMIENTOS_REALIZADOS_NIVEL3 = 3;
const int PAREDES_RANDOM_NIVEL1 = 40;
const int PAREDES_RANDOM_NIVEL2 = 30;
const int PAREDES_RANDOM_NIVEL3 = 20;
const int JUGANDO = 0;
const int GANADO = 1;
const int PERDIDO = -1;
const bool RECOLECTADO = true;
const int SIN_MOVIMIENTOS = 0;
const int SIN_MARTILLOS = 0;
const int SIN_EXTINTORES = 0;
const int TODOS_LOS_NIVELES_GANADOS = 3;

/*PRE: EL parametro limite_rand tiene que contener un valor de dimension de campo(12, 17, 22)
  POST: Le asigna a campos del vector nivel.obstaculos un tipo y una posicion. A una cantidad
  de campos igual a nivel.tope_obstaculos.   
*/
void asignar_posicion_obstaculos(nivel_t* nivel, int cantidad_medias, int limite_rand){

	for(int i = 0; i < (*nivel).tope_obstaculos; i++){
		if( i < cantidad_medias){
			(*nivel).obstaculos[i].tipo = MEDIAS;	
			bool condicion = true;
			while(condicion){
				(*nivel).obstaculos[i].posicion.fil = rand() % limite_rand;
				(*nivel).obstaculos[i].posicion.col = rand() % limite_rand;
				condicion = false;	
				for(int j = 0; j < (*nivel).tope_paredes; j++){
					if(((*nivel).obstaculos[i].posicion.fil == (*nivel).paredes[j].fil)
					&& ((*nivel).obstaculos[i].posicion.col == (*nivel).paredes[j].col)){
						condicion = true;
					}
				}
				if(((*nivel).obstaculos[i].posicion.fil == (*nivel).pos_inicial_jugador.fil)
				&& ((*nivel).obstaculos[i].posicion.col == (*nivel).pos_inicial_jugador.col)){
					condicion = true;
				}
				for(int j = 0; j < i; j++){
					if(((*nivel).obstaculos[i].posicion.fil == (*nivel).obstaculos[j].posicion.fil)
					&& ((*nivel).obstaculos[i].posicion.col == (*nivel).obstaculos[j].posicion.col)){
						condicion = true;
					}
				}
			}		
		}
		if(i >= cantidad_medias){
			(*nivel).obstaculos[i].tipo = FUEGOS;
			bool condicion = true;
			while(condicion){
				(*nivel).obstaculos[i].posicion.fil = rand() % limite_rand;
				(*nivel).obstaculos[i].posicion.col = rand() % limite_rand;
				condicion = false;
				for(int j = 0; j < (*nivel).tope_paredes; j++){
					if(((*nivel).obstaculos[i].posicion.fil == (*nivel).paredes[j].fil)
					&& ((*nivel).obstaculos[i].posicion.col == (*nivel).paredes[j].col)){
						condicion = true;
					}
				}
				int j = 0;
				bool condicion_dos = !condicion;
				while(j < (*nivel).tope_paredes && condicion_dos){
					int distancia = abs((*nivel).obstaculos[i].posicion.fil - (*nivel).paredes[j].fil)
					 			  + abs((*nivel).obstaculos[i].posicion.col - (*nivel).paredes[j].col);
					if(distancia == DISTANCIA_PAREDES){
						condicion_dos = false;
						condicion = false;
					}else {
						condicion = true;
						j++;
					}
					}
				if(((*nivel).obstaculos[i].posicion.fil == (*nivel).pos_inicial_jugador.fil)
				&& ((*nivel).obstaculos[i].posicion.col == (*nivel).pos_inicial_jugador.col)){
					condicion = true;
				}
				for(int k = 0; k < i; k++){
					if(((*nivel).obstaculos[i].posicion.fil == (*nivel).obstaculos[k].posicion.fil)
					&& ((*nivel).obstaculos[i].posicion.col == (*nivel).obstaculos[k].posicion.col)){
						condicion = true;
					}
				}
			}
		}	
	}
}	
/*PRE: EL parametro limite_rand tiene que contener un valor de dimension de campo(12, 17, 22)
  POST: Le asigna a los campos de nivel.herramientas un tipo y una posicion. A una cantidad de campos
  igual a nivel.tope_herramientas.
*/
void asignar_posicion_herramientas(nivel_t* nivel, int cantidad_botella_gritos, int limite_rand){

	for(int i = 0; i < (*nivel).tope_herramientas; i++){
			if(i < cantidad_botella_gritos){
				(*nivel).herramientas[i].tipo = BOTELLA_GRITOS;
			}else{(*nivel).herramientas[i].tipo = INTERRUPTORES;} 
			bool condicion = true;
			while(condicion){
				(*nivel).herramientas[i].posicion.fil = rand() % limite_rand;
				(*nivel).herramientas[i].posicion.col = rand() % limite_rand;
				condicion = false;
				for(int j = 0; j < (*nivel).tope_paredes; j++){
					if(((*nivel).herramientas[i].posicion.fil == (*nivel).paredes[j].fil)
					&& ((*nivel).herramientas[i].posicion.col == (*nivel).paredes[j].col)){
					condicion = true;
					}
				}
				if(((*nivel).herramientas[i].posicion.fil == (*nivel).pos_inicial_jugador.fil)
				&& ((*nivel).herramientas[i].posicion.col == (*nivel).pos_inicial_jugador.col)){
				condicion = true;
				}
				for(int j = 0; j < (*nivel).tope_obstaculos; j++){
					if(((*nivel).herramientas[i].posicion.fil == (*nivel).obstaculos[j].posicion.fil)
					&& ((*nivel).herramientas[i].posicion.col == (*nivel).obstaculos[j].posicion.col)){
						condicion = true;
					}	
				}
				for(int j = 0; j < i; j++){
					if(((*nivel).herramientas[i].posicion.fil == (*nivel).herramientas[j].posicion.fil)
					&& ((*nivel).herramientas[i].posicion.col == (*nivel).herramientas[j].posicion.col)){
						condicion = true;
					}
				}
			}
		}
}
/*PRE: EL parametro limite_rand tiene que contener un valor de dimension de campo(12, 17, 22)
  POST: Le asigna a los campos de nivel.papeleos una posicion, un id_papeleo y una condicion recolectado.
  A una cantidad de campos igual a nivel.tope_papeleos.
*/

void asignar_posicion_papeleos(nivel_t* nivel, int limite_rand){

		for(int i = 0; i < (*nivel).tope_papeleos; i++){
			(*nivel).papeleos[i].recolectado = false;
			(*nivel).papeleos[i].id_papeleo = i + 1;
			bool condicion = true;
			while(condicion){
				(*nivel).papeleos[i].posicion.fil = rand() % limite_rand;
				(*nivel).papeleos[i].posicion.col = rand() % limite_rand;
				condicion = false;
				for(int j = 0; j < (*nivel).tope_paredes; j++){
					if(((*nivel).papeleos[i].posicion.fil == (*nivel).paredes[j].fil)
					&& ((*nivel).papeleos[i].posicion.col == (*nivel).paredes[j].col)){
					condicion = true;
					}
				}
				if(((*nivel).papeleos[i].posicion.fil == (*nivel).pos_inicial_jugador.fil)
				&& ((*nivel).papeleos[i].posicion.col == (*nivel).pos_inicial_jugador.col)){
				condicion = true;
				}
				for(int j = 0; j < (*nivel).tope_obstaculos; j++){
					if(((*nivel).papeleos[i].posicion.fil == (*nivel).obstaculos[j].posicion.fil)
					&& ((*nivel).papeleos[i].posicion.col == (*nivel).obstaculos[j].posicion.col)){
						condicion = true;
					}
				}
				for(int j = 0; j < (*nivel).tope_herramientas; j++){
					if(((*nivel).papeleos[i].posicion.fil == (*nivel).herramientas[j].posicion.fil)
					&& ((*nivel).papeleos[i].posicion.col == (*nivel).herramientas[j].posicion.col)){
						condicion = true;
					}
				}
				for(int j = 0; j < i; j++){
					if(((*nivel).papeleos[i].posicion.fil == (*nivel).papeleos[j].posicion.fil)
					&& ((*nivel).papeleos[i].posicion.col == (*nivel).papeleos[j].posicion.col)){
						condicion = true;
					}
				}
			}
		}

}

/*PRE: EL parametro numero_nivel tiene que contener un valor igual a 1, 2, o 3.
  POST: Le asigna un valor a nivel.tope_obstaculos, nivel.tope_herramientas y nivel.tope_papeleos.
  Devuelve un valor de cantidad_medias, cantidad_botella_gritos y limite_rand.

*/

void asignar_valores_necesarios(nivel_t* nivel, int numero_nivel, char personaje_tp1, int* cantidad_medias,
								 int* cantidad_botella_gritos, int* limite_rand){

	if(numero_nivel == NIVEL1){
		if(personaje_tp1 == OLAF){
				(*nivel).tope_obstaculos = OBSTACULOS_NIVEL1 - 2;
			}else {(*nivel).tope_obstaculos = OBSTACULOS_NIVEL1;}
		*cantidad_medias = MEDIAS_NIVEL1;
		*limite_rand = MAX_CAMPOS_NIVEL1;
		(*nivel).tope_herramientas = HERRAMIENTAS_NIVEL1;
		*cantidad_botella_gritos = BOTELLA_GRITOS_NIVEL1;
		(*nivel).tope_papeleos = PAPELEOS_NIVEL1;
	}
	if(numero_nivel == NIVEL2){
		if(personaje_tp1 == OLAF){
				(*nivel).tope_obstaculos = OBSTACULOS_NIVEL2 - 1; 
			}else {(*nivel).tope_obstaculos = OBSTACULOS_NIVEL2;}
		*cantidad_medias = MEDIAS_NIVEL2;
		*limite_rand = MAX_CAMPOS_NIVEL2;
		(*nivel).tope_herramientas = HERRAMIENTAS_NIVEL2;
		*cantidad_botella_gritos = BOTELLA_GRITOS_NIVEL2;
		(*nivel).tope_papeleos = PAPELEOS_NIVEL2;
	}
	if(numero_nivel == NIVEL3){
		(*nivel).tope_obstaculos = OBSTACULOS_NIVEL3;
		*cantidad_medias = MEDIAS_NIVEL3;
		*limite_rand = MAX_CAMPOS_NIVEL3;
		(*nivel).tope_herramientas = HERRAMIENTAS_NIVEL3;
		*cantidad_botella_gritos = HERRAMIENTAS_NIVEL3;
		if(personaje_tp1 == STITCH){
			(*nivel).tope_papeleos = PAPELEOS_NIVEL3 - 1;
		}else{(*nivel).tope_papeleos = PAPELEOS_NIVEL3;}
	}

}
/*PRE:
  POST: Le asigna valores a juego.nivel_actual, juego.jugador y juego.personaje_tp1.
*/
void cargar_informacion_inicial(juego_t* juego, char personaje_tp1){


	(*juego).personaje_tp1 = personaje_tp1;
	(*juego).nivel_actual = NIVEL_ACTUAL;

	if((*juego).nivel_actual == NIVEL1){
		(*juego).jugador.posicion.fil = (*juego).niveles[INDICE_NIVEL1].pos_inicial_jugador.fil;
		(*juego).jugador.posicion.col = (*juego).niveles[INDICE_NIVEL1].pos_inicial_jugador.col;
		if((*juego).personaje_tp1 == RAYO_MCQUEEN){
			(*juego).jugador.movimientos = MOVIMIENTOS_NIVEL1 + 10;	
		}else {(*juego).jugador.movimientos = MOVIMIENTOS_NIVEL1;}
		if((*juego).personaje_tp1 == JASMIN){
			(*juego).jugador.martillos = MARTILLOS_NIVEL1 + 1;
		}else{(*juego).jugador.martillos = MARTILLOS_NIVEL1;}
		(*juego).jugador.extintores = EXTINTORES_NIVEL1;
		(*juego).jugador.ahuyenta_randall = DESACTIVADO;
		(*juego).jugador.movimientos_realizados = 0;
	}
	if((*juego).nivel_actual == NIVEL2){
		(*juego).jugador.posicion.fil = (*juego).niveles[INDICE_NIVEL2].pos_inicial_jugador.fil;
		(*juego).jugador.posicion.col = (*juego).niveles[INDICE_NIVEL2].pos_inicial_jugador.col;
		(*juego).jugador.movimientos = MOVIMIENTOS_NIVEL2;
		if((*juego).personaje_tp1 == JASMIN){
			(*juego).jugador.martillos = MARTILLOS_NIVEL2 + 1;
		}else{(*juego).jugador.martillos = MARTILLOS_NIVEL2;}
		(*juego).jugador.extintores = EXTINTORES_NIVEL2;
		(*juego).jugador.ahuyenta_randall = DESACTIVADO;
		(*juego).jugador.movimientos_realizados = 0;		
	}
	if((*juego).nivel_actual == NIVEL3){
		(*juego).jugador.posicion.fil = (*juego).niveles[INDICE_NIVEL3].pos_inicial_jugador.fil;
		(*juego).jugador.posicion.col = (*juego).niveles[INDICE_NIVEL3].pos_inicial_jugador.col;
		(*juego).jugador.movimientos = MOVIMIENTOS_NIVEL3;
		if((*juego).personaje_tp1 == JASMIN){
			(*juego).jugador.martillos = MARTILLOS_NIVEL3 + 1;
		}else{(*juego).jugador.martillos = MARTILLOS_NIVEL3;}
		(*juego).jugador.extintores = EXTINTORES_NIVEL3;
		(*juego).jugador.ahuyenta_randall = DESACTIVADO;
		(*juego).jugador.movimientos_realizados = 0;
	}
}
/*PRE: max_campos tiene que contener un valor de dimension(12,17,22), indice debe ser 0, 1 o 2.
  POST: imprime una matriz de dimensiones max_campos, representando todos los elementos del "mapa"
  de juego.niveles[indice].
*/
void imprimir_campo_juego(juego_t juego, int max_campos, int indice){

	char campo_juego[max_campos][max_campos];

	for(int i = 0; i < max_campos; i++){
			for(int j = 0; j < max_campos; j++){
				bool condicion = true;
				for(int k = 0; k < juego.niveles[indice].tope_paredes; k++){
					if(juego.niveles[indice].paredes[k].fil == i && juego.niveles[indice].paredes[k].col == j){
						campo_juego[i][j] = PARED;
						condicion = false;
					}
				}
				for(int k = 0; k < juego.niveles[indice].tope_obstaculos; k++){
					if(juego.niveles[indice].obstaculos[k].posicion.fil == i && juego.niveles[indice].obstaculos[k].posicion.col == j){
						campo_juego[i][j] = juego.niveles[indice].obstaculos[k].tipo;
						condicion = false;
					}
				}
				for(int k = 0; k < juego.niveles[indice].tope_herramientas; k++){
					if(juego.niveles[indice].herramientas[k].posicion.fil == i && juego.niveles[indice].herramientas[k].posicion.col == j){
						campo_juego[i][j] = juego.niveles[indice].herramientas[k].tipo;
						condicion = false;
					}
				}
				for(int k = 0; k < juego.niveles[indice].tope_papeleos; k++){
					if(juego.niveles[indice].papeleos[k].posicion.fil == i && juego.niveles[indice].papeleos[k].posicion.col == j && juego.niveles[indice].papeleos[k].recolectado == false){
						campo_juego[i][j] = (char)(ASCII_0 + juego.niveles[indice].papeleos[k].id_papeleo);
						condicion = false;
					}
				}
				if(juego.jugador.posicion.fil == i && juego.jugador.posicion.col == j){
					campo_juego[i][j] = WAZOWSKI;
					condicion = false;
				}
				if(condicion){
					campo_juego[i][j] = CAMPO_VACIO;
				}
			}
		}
		for(int i = 0; i < max_campos; i++){
			for(int j = 0; j < max_campos; j++){
				printf(" %c", campo_juego[i][j]);
			}
			printf("\n");
		}

}

/*PRE: numero_nivel tiene que contener un valor 1, 2 o 3. 
  POST: le asigna valores a todos los parametros que contiene nivel.
 */

void inicializar_nivel(nivel_t* nivel, int numero_nivel, char personaje_tp1){

	obtener_paredes(numero_nivel, (*nivel).paredes, &((*nivel).tope_paredes), &((*nivel).pos_inicial_jugador));

	int cantidad_medias = 0;
	int cantidad_botella_gritos = 0;
	int limite_rand = 0;

	asignar_valores_necesarios(nivel, numero_nivel, personaje_tp1, &cantidad_medias, &cantidad_botella_gritos, &limite_rand);
	asignar_posicion_obstaculos(nivel, cantidad_medias, limite_rand);
	asignar_posicion_herramientas(nivel, cantidad_botella_gritos, limite_rand);
	asignar_posicion_papeleos(nivel, limite_rand);

}

/*PRE:  
  POST: Le asignara los valores inciales a juego.nivel[INDICE_NIVEL1], juego.nivel[INDICE_NIVEL2]
   		y juego.nivel[INDICE_NIVEL3].
   		Cargara la informacion incial a juego.
 */

void inicializar_juego(juego_t* juego, char personaje_tp1){
	
	inicializar_nivel(&((*juego).niveles[INDICE_NIVEL1]), NIVEL1, personaje_tp1);
	inicializar_nivel(&((*juego).niveles[INDICE_NIVEL2]), NIVEL2, personaje_tp1);
	inicializar_nivel(&((*juego).niveles[INDICE_NIVEL3]), NIVEL3, personaje_tp1);

	cargar_informacion_inicial(juego, personaje_tp1);
}

/*PRE: 
  POST: Imprime toda la informacion actual de juego.
 */
void imprimir_terreno(juego_t juego){

	printf("NIVEL ACTUAL: %i\n", juego.nivel_actual);
	printf("POSICION: ( %i ; %i )\n", juego.jugador.posicion.fil, juego.jugador.posicion.col);
	printf("MOVIMIENTOS: %i\n", juego.jugador.movimientos);
	printf("MARTILLOS: %i\n", juego.jugador.martillos);
	printf("EXTINTORES: %i\n", juego.jugador.extintores);
	printf("MOVIMIENTOS REALIZADOS: %i\n", juego.jugador.movimientos_realizados);
	if(juego.personaje_tp1 == STITCH){
		printf("PERSONAJE TP1: -Stitch- \n");
	}
	if(juego.personaje_tp1 == JASMIN){
		printf("PERSONAJE TP1: -Jasmín-\n");
	}
	if(juego.personaje_tp1 == OLAF){
		printf("PERSONAJE TP1: -Olaf-\n");
	}
	if(juego.personaje_tp1 == RAYO_MCQUEEN){
		printf("PERSONAJE TP1: -Rayo McQueen-\n");
	}
	if(juego.jugador.ahuyenta_randall){
		printf("AHUYENTA RANDALL: ACTIVADO\n");
	}else{ printf("AHUYENTA RANDALL: DESACTIVADO\n");}

	if(juego.nivel_actual == NIVEL1){

		imprimir_campo_juego(juego, MAX_CAMPOS_NIVEL1, INDICE_NIVEL1);

	}
	if(juego.nivel_actual == NIVEL2){

		imprimir_campo_juego(juego, MAX_CAMPOS_NIVEL2, INDICE_NIVEL2);
	}
	if(juego.nivel_actual == NIVEL3){

		imprimir_campo_juego(juego, MAX_CAMPOS_NIVEL3, INDICE_NIVEL3);
	}	

}


//TP3--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//TP3--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//TP3--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//PRE: El vector papeleos no debe estar vacio
//POST: Devuelve el estado del nivel, si todos los papeleos estan recolectados devuelve GANADO, si no, devuelve JUGANDO.
int estado_nivel(papeleo_t papeleos[MAX_PAPELEOS], int tope_papeleos){
	int estado = GANADO;
	int i = 0;
	while((i < tope_papeleos) && estado){
		if(!(papeleos[i].recolectado)){
			estado = JUGANDO;
		}
		i++;
	}
	return estado;
}

//PRE: Los campos de juego deben estar inicializados
//POST: Devuelve el estado del juego, GANADO, PERDIDO, o JUGANDO.
int estado_juego(juego_t juego){
	int estado_del_juego;
	int estado_nivel_1 = estado_nivel(juego.niveles[INDICE_NIVEL1].papeleos, juego.niveles[INDICE_NIVEL1].tope_papeleos);
	int estado_nivel_2 = estado_nivel(juego.niveles[INDICE_NIVEL2].papeleos, juego.niveles[INDICE_NIVEL2].tope_papeleos);
	int estado_nivel_3 = estado_nivel(juego.niveles[INDICE_NIVEL3].papeleos, juego.niveles[INDICE_NIVEL3].tope_papeleos);
	int suma_estados = estado_nivel_1 + estado_nivel_2 + estado_nivel_3;
	if(juego.jugador.movimientos <= SIN_MOVIMIENTOS){
		estado_del_juego = PERDIDO;
	}else if(suma_estados >= TODOS_LOS_NIVELES_GANADOS){
		estado_del_juego = GANADO;
	}else {
		estado_del_juego = JUGANDO;
	}
	return estado_del_juego;
}

//PRE: el campo juego.nivel_actual debe estar inicializado.
//POST: De acuerdo al valor de juego.nivel_actual devuelve el parametro, valor_nivel_1,
//     valor_nivel_2 o valor_nivel_3.
int valor_para_el_nivel_actual(juego_t* juego, int valor_nivel_1, int valor_nivel_2, int valor_nivel_3){
	int valor_correspondiente;
	if((*juego).nivel_actual == NIVEL1){
		valor_correspondiente = valor_nivel_1;
	}else if((*juego).nivel_actual == NIVEL2){
		valor_correspondiente = valor_nivel_2;
	}else {
		valor_correspondiente = valor_nivel_3;
	}
	return valor_correspondiente;
}

//PRE: los campos de juego deben estar inicializados.
//POST: Rota las coordenadas de los elementos de juego.niveles[i] en sentido horario. 
void rotar_campo_horario(juego_t* juego, nivel_t* nivel_jugando){
	int max_fil_col = valor_para_el_nivel_actual(juego, (MAX_CAMPOS_NIVEL1-1), (MAX_CAMPOS_NIVEL2-1), (MAX_CAMPOS_NIVEL3-1));
	for(int i = 0; i < (*nivel_jugando).tope_paredes; i++){
		int aux = (*nivel_jugando).paredes[i].fil;
		(*nivel_jugando).paredes[i].fil = (*nivel_jugando).paredes[i].col;
		(*nivel_jugando).paredes[i].col = (abs(aux - max_fil_col));
	}
	for(int i = 0; i < (*nivel_jugando).tope_obstaculos; i++){
		int aux = (*nivel_jugando).obstaculos[i].posicion.fil;
		(*nivel_jugando).obstaculos[i].posicion.fil = (*nivel_jugando).obstaculos[i].posicion.col;
		(*nivel_jugando).obstaculos[i].posicion.col = (abs(aux - max_fil_col));	
	}
	for(int i = 0; i < (*nivel_jugando).tope_herramientas; i++){
		int aux = (*nivel_jugando).herramientas[i].posicion.fil;
		(*nivel_jugando).herramientas[i].posicion.fil = (*nivel_jugando).herramientas[i].posicion.col;
		(*nivel_jugando).herramientas[i].posicion.col = (abs(aux - max_fil_col));	
	}
	for(int i = 0; i < (*nivel_jugando).tope_papeleos; i++){
		int aux = (*juego).niveles[(*juego).nivel_actual-1].papeleos[i].posicion.fil;
		(*nivel_jugando).papeleos[i].posicion.fil = (*nivel_jugando).papeleos[i].posicion.col;
		(*nivel_jugando).papeleos[i].posicion.col = (abs(aux - max_fil_col));	
	}
	int aux = (*juego).jugador.posicion.fil;
	(*juego).jugador.posicion.fil = (*juego).jugador.posicion.col;
	(*juego).jugador.posicion.col = (abs(aux - max_fil_col));
}

//PRE: Los campos de juego deben estar inicializados.
//POST: Rota las coordenadas de los elementos de juego.nivekes[i] en sentido antihorario.
void rotar_campo_antihorario(juego_t* juego, nivel_t* nivel_jugando){
	int max_fil_col = valor_para_el_nivel_actual(juego, (MAX_CAMPOS_NIVEL1-1), (MAX_CAMPOS_NIVEL2-1), (MAX_CAMPOS_NIVEL3-1));
	for(int i = 0; i < (*nivel_jugando).tope_paredes; i++){
		int aux = (*nivel_jugando).paredes[i].col;	
		(*nivel_jugando).paredes[i].col = (*nivel_jugando).paredes[i].fil;
		(*nivel_jugando).paredes[i].fil = (abs(aux - max_fil_col));
	}
	for(int i = 0; i < (*nivel_jugando).tope_obstaculos; i++){
		int aux = (*nivel_jugando).obstaculos[i].posicion.col;
		(*nivel_jugando).obstaculos[i].posicion.col = (*nivel_jugando).obstaculos[i].posicion.fil;
		(*nivel_jugando).obstaculos[i].posicion.fil = (abs(aux - max_fil_col));	
	}
	for(int i = 0; i < (*nivel_jugando).tope_herramientas; i++){
		int aux = (*nivel_jugando).herramientas[i].posicion.col;
		(*nivel_jugando).herramientas[i].posicion.col = (*nivel_jugando).herramientas[i].posicion.fil;
		(*nivel_jugando).herramientas[i].posicion.fil = (abs(aux - max_fil_col));	
	}
	for(int i = 0; i < (*nivel_jugando).tope_papeleos; i++){
		int aux = (*nivel_jugando).papeleos[i].posicion.col;
		(*nivel_jugando).papeleos[i].posicion.col = (*nivel_jugando).papeleos[i].posicion.fil;
		(*nivel_jugando).papeleos[i].posicion.fil = (abs(aux - max_fil_col));	
	}
	int aux = (*juego).jugador.posicion.col;
	(*juego).jugador.posicion.col = (*juego).jugador.posicion.fil;
	(*juego).jugador.posicion.fil = (abs(aux - max_fil_col));

}

//PRE: Los campos de juego deben estar inicializados.
//POST: Devuelve una fil y una col valida, donde no haya otro elemento de juego.niveles[i] con la misma coordenada.
void asignar_posicion_elemento(juego_t* juego, int* fil, int* col, nivel_t* nivel_jugando){
	int i;
	bool posicion_es_valida = false;
	int limite_rand = valor_para_el_nivel_actual(juego, MAX_CAMPOS_NIVEL1, MAX_CAMPOS_NIVEL2, MAX_CAMPOS_NIVEL3);
	while(!posicion_es_valida){
		*fil = rand() % limite_rand;
		*col = rand() % limite_rand;
		i = 0;
		posicion_es_valida = true;
		while(i < (*nivel_jugando).tope_paredes && posicion_es_valida){
			if((*fil == (*nivel_jugando).paredes[i].fil) 
			&& (*col == (*nivel_jugando).paredes[i].col)){
					posicion_es_valida = false;
			}
			i++;
		}
		i = 0;
		while(i < (*nivel_jugando).tope_obstaculos && posicion_es_valida){
			if((*fil == (*nivel_jugando).obstaculos[i].posicion.fil) 
			&& (*col == (*nivel_jugando).obstaculos[i].posicion.col)){
				posicion_es_valida = false;
			}
			i++;
		}
		i = 0;
		while(i < (*nivel_jugando).tope_herramientas && posicion_es_valida){
			if((*fil == (*nivel_jugando).herramientas[i].posicion.fil) 
			&& (*col == (*nivel_jugando).herramientas[i].posicion.col)){
				posicion_es_valida = false;
			}
			i++;
		}
		i = 0;
		while(i < (*nivel_jugando).tope_papeleos && posicion_es_valida){
			if((*fil == (*nivel_jugando).papeleos[i].posicion.fil) 
			 && (*col == (*nivel_jugando).papeleos[i].posicion.col)
			 && !((*nivel_jugando).papeleos[i].recolectado)){
				posicion_es_valida = false;
			}
			i++;
		}
		if((*fil == (*juego).jugador.posicion.fil) && (*col == (*juego).jugador.posicion.col)){
			posicion_es_valida = false;
		}
	}
}

//PRE: Los campos de juego.niveles[i].paredes deben estar inicializados.
//POST: Devuelve true o false, si encontro la coordenada de una pared que esta en la direccion del parametro.
bool hay_pared(juego_t* juego, char direccion, nivel_t* nivel_jugando){
	int suma_fil = 0, suma_col = 0;
	if(direccion == DIRECCION_DERECHA){
		suma_fil = 0, suma_col = 1;
	}
	if(direccion == DIRECCION_IZQUIERDA){
		suma_fil = 0, suma_col = -1;
	}
	if(direccion == DIRECCION_ARRIBA){
		suma_fil = -1, suma_col = 0;
	}
	if(direccion == DIRECCION_ABAJO){
		suma_fil = 1, suma_col = 0;
	}
	bool pared_en_direccion = false;
	int i = 0;
	while(i < (*nivel_jugando).tope_paredes && !pared_en_direccion){
		if(((*juego).jugador.posicion.col + suma_col == (*nivel_jugando).paredes[i].col) && 
		   ((*juego).jugador.posicion.fil + suma_fil == (*nivel_jugando).paredes[i].fil)){
			pared_en_direccion = true;
		}
		i++;
	}
	return pared_en_direccion;;
}

//PRE: Los campos de juego.niveles[i].paredes deben estar inicializados.
//	   Debe haber una pared en la direccion que indica el parametro.
//POST: Deveuelve el indice de la pared que esta en la direccion del parametro.
int indice_pared(juego_t* juego, char direccion, nivel_t* nivel_jugando){
	int suma_fil = 0, suma_col = 0;
	if(direccion == DIRECCION_DERECHA){
		suma_fil = 0, suma_col = 1;
	}
	if(direccion == DIRECCION_IZQUIERDA){
		suma_fil = 0, suma_col = -1;
	}
	if(direccion == DIRECCION_ARRIBA){
		suma_fil = -1, suma_col = 0;
	}
	if(direccion == DIRECCION_ABAJO){
		suma_fil = 1, suma_col = 0;
	}
	bool pared_en_direccion = false;
	int i = 0;
	while(i < (*nivel_jugando).tope_paredes && !pared_en_direccion){
		if(((*juego).jugador.posicion.col + suma_col == (*nivel_jugando).paredes[i].col) && 
		   ((*juego).jugador.posicion.fil + suma_fil == (*nivel_jugando).paredes[i].fil)){
			pared_en_direccion = true;
		}
		i++;
	}
	return (i-1);
}

//PRE: Los campos de juego.niveles[i].paredes deben estar inicializados.
//	   Debe haber una pared en la direccion que indica el parametro.
//POST: Devuelve true o false, si la pared en la direccion que indica el parametro pertece al borde del terreno.
bool puedo_martillar(juego_t* juego, char direccion, nivel_t* nivel_jugando){
	int max_fil_col = valor_para_el_nivel_actual(juego, (MAX_CAMPOS_NIVEL1-1), (MAX_CAMPOS_NIVEL2-1), (MAX_CAMPOS_NIVEL3-1));
	bool puedo_martillar = true;
	int indice_pared_en_direccion = indice_pared(juego, direccion, nivel_jugando);
	if(((*nivel_jugando).paredes[indice_pared_en_direccion].col == 0) ||
	    ((*nivel_jugando).paredes[indice_pared_en_direccion].col == max_fil_col) ||
	     ((*nivel_jugando).paredes[indice_pared_en_direccion].fil == 0) ||
	      ((*nivel_jugando).paredes[indice_pared_en_direccion].fil == max_fil_col)){
		puedo_martillar = false;
	}
	return puedo_martillar;
}

//PRE: Los campos de juego.niveles[i].paredes deben estar inicializados.
//		Debe haber una pared en la direccion que indica el parametro.
//POST: Reemplaza la pared que esta en la direccion que indica el parametro, por la ultima pared en el vector,
// 		resta uno al tope_paredes, y resta uno a juego.jugador.martillos.
void usar_martillo(juego_t* juego, char direccion, nivel_t* nivel_jugando){
	int indice_pared_en_direccion = indice_pared(juego, direccion, nivel_jugando);
	(*nivel_jugando).paredes[indice_pared_en_direccion] = (*nivel_jugando).paredes[(*nivel_jugando).tope_paredes -1];		
	(*nivel_jugando).tope_paredes--;
	(*juego).jugador.martillos--;
}
//PRE: Los campos de juego.niveles[i] deben estar inicializados.
//POST: Devuelve true o false, si encontro la coordenada de un fuego que esta en la direccion que indica el parametro.
bool hay_fuego(juego_t* juego, char direccion, nivel_t* nivel_jugando){
	int suma_fil = 0, suma_col = 0;
	if(direccion == DIRECCION_DERECHA){
		suma_fil = 0, suma_col = 1;
	}
	if(direccion == DIRECCION_IZQUIERDA){
		suma_fil = 0, suma_col = -1;
	}
	if(direccion == DIRECCION_ARRIBA){
		suma_fil = -1, suma_col = 0;
	}
	bool fuego_en_direccion = false;
	int inicio_fuegos = valor_para_el_nivel_actual(juego, MEDIAS_NIVEL1, MEDIAS_NIVEL2, MEDIAS_NIVEL3);
	int i = inicio_fuegos;
	while(i < (*nivel_jugando).tope_obstaculos && !fuego_en_direccion){
		if(((*juego).jugador.posicion.col + suma_col == (*nivel_jugando).obstaculos[i].posicion.col) && 
		   ((*juego).jugador.posicion.fil + suma_fil == (*nivel_jugando).obstaculos[i].posicion.fil)){
			fuego_en_direccion = true;
		}
		i++;
	}
	return fuego_en_direccion;
}
//PRE: Los campos de juego.niveles[i] deben estar inicializados.
//	   Debe haber una fuego en la direccion que indica el parametro.
//POST: Deveuelve el indice del fuego que esta en la direccion que indica el parametro.
int indice_fuego(juego_t* juego, char direccion, nivel_t* nivel_jugando){
	int suma_fil = 0, suma_col = 0;
	if(direccion == DIRECCION_DERECHA){
		suma_fil = 0, suma_col = 1;
	}
	if(direccion == DIRECCION_IZQUIERDA){
		suma_fil = 0, suma_col = -1;
	}
	if(direccion == DIRECCION_ARRIBA){
		suma_fil = -1, suma_col = 0;
	}
	bool fuego_en_direccion = false;
	int inicio_fuegos = valor_para_el_nivel_actual(juego, MEDIAS_NIVEL1, MEDIAS_NIVEL2, MEDIAS_NIVEL3);
	int i = inicio_fuegos;
	while(i < (*nivel_jugando).tope_obstaculos && !fuego_en_direccion){
		if(((*juego).jugador.posicion.col + suma_col == (*nivel_jugando).obstaculos[i].posicion.col) && 
		   ((*juego).jugador.posicion.fil + suma_fil == (*nivel_jugando).obstaculos[i].posicion.fil)){
			fuego_en_direccion = true;
		}
		i++;
	}
	return (i-1);
}

//PRE: Los campos de juego.niveles[i] deben estar inicializados.
//		Debe haber una pared en la direccion que indica el parametro.
//POST: Reemplaza el fuego que esta en la direccion que indica el parametro, por el ultimo fuego en el vector,
// 		,resta uno al tope_obstaculos, y resta uno a juego.jugador.extintores.
void usar_extintor(juego_t* juego, char direccion, nivel_t* nivel_jugando){
	int indice_fuego_en_direccion = indice_fuego(juego, direccion, nivel_jugando);
	(*nivel_jugando).obstaculos[indice_fuego_en_direccion] = (*nivel_jugando).obstaculos[(*nivel_jugando).tope_obstaculos -1];		
	(*nivel_jugando).tope_obstaculos--;
	(*juego).jugador.extintores--;
}

//PRE: Los campos de juego deben estar inicaializados.
//POST: Devuelve true o false, si en la posicion actual del jugador hay un fuego.
bool estoy_en_fuego(juego_t* juego, nivel_t* nivel_jugando){
	int inicio_fuegos = valor_para_el_nivel_actual(juego, MEDIAS_NIVEL1, MEDIAS_NIVEL2, MEDIAS_NIVEL3);
	bool pise_fuego = false;
	int i = inicio_fuegos;
	while(i < (*nivel_jugando).tope_obstaculos && !pise_fuego){
		if(((*juego).jugador.posicion.col == (*nivel_jugando).obstaculos[i].posicion.col) && 
		   ((*juego).jugador.posicion.fil == (*nivel_jugando).obstaculos[i].posicion.fil)){
			pise_fuego = true;
		}
		i++;
	}
	return pise_fuego;
}

//PRE: Los campos de juego deben estar inicaializados.
//POST: Devuelve true o false, si en la posicion actual del jugador hay una media.
bool estoy_en_media(juego_t* juego, nivel_t* nivel_jugando){
	int tope_medias = valor_para_el_nivel_actual(juego, MEDIAS_NIVEL1, MEDIAS_NIVEL2, MEDIAS_NIVEL3);
	int i = 0;
	bool estoy_en_media = false;
	while(i < tope_medias && !estoy_en_media){
		if((*juego).jugador.posicion.col == (*nivel_jugando).obstaculos[i].posicion.col && 
		   (*juego).jugador.posicion.fil == (*nivel_jugando).obstaculos[i].posicion.fil){
			estoy_en_media = true;
		}
		i++;
	} 
	return estoy_en_media;
}

//PRE: Los campos de juego deben estar inicaializados.
//POST: Devuelve true o false, si en la posicion actual del jugador hay un interruptor.
bool pise_interruptor(juego_t* juego, nivel_t* nivel_jugando){
	bool pise_interruptor = false;
	if((*juego).nivel_actual == NIVEL1 || (*juego).nivel_actual == NIVEL2){
		pise_interruptor = ((*nivel_jugando).herramientas[(*nivel_jugando).tope_herramientas -1].posicion.fil == (*juego).jugador.posicion.fil &&
		   			   		(*nivel_jugando).herramientas[(*nivel_jugando).tope_herramientas -1].posicion.col == (*juego).jugador.posicion.col);
	}
	return pise_interruptor;
}

//PRE: Los campos de juego deben estar inicaializados.
//POST: Devuelve true o false, si en la posicion actual del jugador hay una botella de gritos.
bool pise_botella_gritos(juego_t* juego, nivel_t* nivel_jugando){
	bool pise_botella_gritos = false;
	int tope_botella_gritos = valor_para_el_nivel_actual(juego, BOTELLA_GRITOS_NIVEL1, BOTELLA_GRITOS_NIVEL2, HERRAMIENTAS_NIVEL3);
	int i = 0;
	while(i < tope_botella_gritos && !pise_botella_gritos){
		if((*nivel_jugando).herramientas[i].posicion.fil == (*juego).jugador.posicion.fil &&
		   (*nivel_jugando).herramientas[i].posicion.col == (*juego).jugador.posicion.col){
			pise_botella_gritos = true;
		}
		i++;
	}
	return pise_botella_gritos;
}

//PRE: Los campos de juego deben estar inicaializados.
//POST: Devuelve true o false, si en la posicion actual del jugador un papeleo, y este no se encuentra recolectado.
bool estoy_en_papeleo(juego_t* juego, nivel_t* nivel_jugando){
	bool estoy_en_papeleo = false;
	int i = 0;
	while(i < (*nivel_jugando).tope_papeleos && !estoy_en_papeleo){
		if((*juego).jugador.posicion.fil == (*nivel_jugando).papeleos[i].posicion.fil &&
		   (*juego).jugador.posicion.col == (*nivel_jugando).papeleos[i].posicion.col &&
		   !((*nivel_jugando).papeleos[i].recolectado)){
			estoy_en_papeleo = true;
		}
		i++;
	}
	return estoy_en_papeleo;
}

//PRE: Los campos de juego deben estar inicializados.
// 		Debe haber un papeleo en la posicion actual del jugador.
//POST: Devuelve el indice del papeleo que esta en la posicion actual del jugador.
int indice_papeleo(juego_t* juego, nivel_t* nivel_jugando){
	bool estoy_en_papeleo = false;
	int i = 0;
	while(i < (*nivel_jugando).tope_papeleos && !estoy_en_papeleo){
		if((*juego).jugador.posicion.fil == (*nivel_jugando).papeleos[i].posicion.fil &&
		   (*juego).jugador.posicion.col == (*nivel_jugando).papeleos[i].posicion.col &&
		   !((*nivel_jugando).papeleos[i].recolectado)){
			estoy_en_papeleo = true;
		}
		i++;
	}
	return (i-1);
}

//PRE: Los campos de juego deben estar inicializados.
//POST: Devuelve true o false, si los papeleos con indice menor al indice del papeleo en el que estoy actualmente
//		ya fueron recolectados.
bool puedo_recoger_papeleo(juego_t* juego, nivel_t* nivel_jugando){
	bool agarro_papeleo = true;
	int posicion_papeleo_encontrado = indice_papeleo(juego, nivel_jugando);
	int i = 0;
	while((i < posicion_papeleo_encontrado) && agarro_papeleo){
		if(!((*nivel_jugando).papeleos[i].recolectado)){
			agarro_papeleo = false;
		}
		i++;
	}
	return agarro_papeleo;
}
//PRE: Los campos de juego deben estar inicializados.
//POST: Deveuelve true o false, si el valor de jugador.movimientos_realizados es un multiplo de divisor, 
//		juego.ahuyenta_randall se encuentra desactivado, y estado_nivel() es igual a JUGANDO.
//COMENTARIO: la ultima condicion de estado_nivel() == JUGANDO, lo hago para que no se de el caso en que
//				los movimientos realizados son multiplos de divisor y el ahuyenta randall este desactivado, pero ya 
//				haya recolectado todos los papeleos(por ejemplo, hago un movimiento y agarro el ultimo papeleo),
//				 porque en ese caso randall_mueve_papeleo me daria true, y mi funcion mover_papeleo
//				se quedaria en bucle tratando de encontrar un papel no recolectado.
bool randall_mueve_papeleo(juego_t* juego, nivel_t* nivel_jugando){
	bool muevo_papeleo = false;
	int divisor = valor_para_el_nivel_actual(juego, DIVISOR_DE_MOVIMIENTOS_REALIZADOS_NIVEL1,
	 DIVISOR_DE_MOVIMIENTOS_REALIZADOS_NIVEL2, DIVISOR_DE_MOVIMIENTOS_REALIZADOS_NIVEL3);
	if((((*juego).jugador.movimientos_realizados % divisor) == 0) && !((*juego).jugador.ahuyenta_randall)
		&& (estado_nivel((*nivel_jugando).papeleos, (*nivel_jugando).tope_papeleos) == JUGANDO)){
		muevo_papeleo = true;
	}
	return muevo_papeleo;
}

//PRE: Los campos de juego deben estar inicializados.
//POST: Le asigna una coordenada aleatoria valida a un papeleo aleatorio que no haya sido recolectado.
void mover_papeleo(juego_t* juego, nivel_t* nivel_jugando){
	int fil,col;
	int indice_papeleo = rand() % ((*nivel_jugando).tope_papeleos);
	while((*nivel_jugando).papeleos[indice_papeleo].recolectado){
		indice_papeleo = rand() % ((*nivel_jugando).tope_papeleos);	
	}
	asignar_posicion_elemento(juego, &fil, &col, nivel_jugando);
	(*nivel_jugando).papeleos[indice_papeleo].posicion.fil = fil;
	(*nivel_jugando).papeleos[indice_papeleo].posicion.col = col;
}

//PRE: Los campos de juego deben estar inicializados.
//POST: Devuelve true o false, si jugador.movimientos_realizados es menor a cant_paredes_random, y realize un movimiento.
bool aparece_pared_random(juego_t* juego, bool realize_movimiento){
	int cant_paredes_random = valor_para_el_nivel_actual(juego, PAREDES_RANDOM_NIVEL1, PAREDES_RANDOM_NIVEL2, PAREDES_RANDOM_NIVEL3);
	bool aparecer_pared = false;
	if(((*juego).jugador.movimientos_realizados <= cant_paredes_random) && realize_movimiento){
		aparecer_pared = true;
	}
	return aparecer_pared;
}
//PRE: Los campos de juego deben estar inicializados.
//POST: Devuelve true o false, si sumando 1 a jugador.posicion.fil coincide con la posicion de una pared.
bool vacio_abajo(juego_t* juego, nivel_t* nivel_jugando){
	bool espacio_libre = true;
	int i = 0;
	while(i < (*nivel_jugando).tope_paredes && espacio_libre){
		if((*juego).jugador.posicion.fil +1 == (*nivel_jugando).paredes[i].fil && (*juego).jugador.posicion.col == (*nivel_jugando).paredes[i].col){
			espacio_libre = false;
		}
		i++;
	}
	return espacio_libre;
}

//PRE: Los campos de juego deben estar inicializados.
//POST: Incrementa el tope paredes en 1, y le asigna a la pared nueva una posicion valida y aleatoria.
void nueva_pared_random(juego_t* juego, nivel_t* nivel_jugando){
	(*nivel_jugando).tope_paredes++;
	int fil, col;
	asignar_posicion_elemento(juego, &fil, &col, nivel_jugando);
	(*nivel_jugando).paredes[(*nivel_jugando).tope_paredes -1].fil = fil;
	(*nivel_jugando).paredes[(*nivel_jugando).tope_paredes -1].col = col;
}

//PRE: Los campos de juego deben estar inicializados.
//POST: Realiza la accion correspondiente al interactuar con algun elemento del juego.
void realizar_interacciones(juego_t* juego, nivel_t* nivel_jugando, bool realize_movimiento_lateral){
	if(estoy_en_fuego(juego, nivel_jugando)){
		(*juego).jugador.movimientos = SIN_MOVIMIENTOS;
	}
	if(estoy_en_media(juego, nivel_jugando) && realize_movimiento_lateral){
		(*juego).jugador.movimientos +=  -MOVIMIENTOS_PERDIDOS_POR_MEDIA;
	}
	if(pise_interruptor(juego, nivel_jugando) && realize_movimiento_lateral){
		(*juego).jugador.ahuyenta_randall = !((*juego).jugador.ahuyenta_randall);
	}
	if(pise_botella_gritos(juego, nivel_jugando) && realize_movimiento_lateral){
		(*juego).jugador.movimientos += MOVIMIENTOS_GANADOS_POR_BOTELLA;
	}
	if(estoy_en_papeleo(juego, nivel_jugando) && puedo_recoger_papeleo(juego, nivel_jugando)){
		int indice_papeleo_recolectado = indice_papeleo(juego, nivel_jugando);
		(*nivel_jugando).papeleos[indice_papeleo_recolectado].recolectado = RECOLECTADO;	
	}
}

//PRE: Los campos de juego deben estar inicializados.
//POST: Realiza todas las acciones correspondientes del juego, luego de realizar un movimiento.
//COMENTARIO: En el while uso el estado_nivel y estado_juego para verificar en cada iteracion si el personaje
//				agarro todos los papeleos y gano el nivel, o si choco con un fuego y perdio el juego.
//				asi el personaje se frena en esa posicion y no sigue cayendo.
void realizar_acciones_del_juego(juego_t* juego, bool realize_movimiento_lateral, bool realize_movimiento_rotacional, nivel_t* nivel_jugando){
	realizar_interacciones(juego, nivel_jugando, realize_movimiento_lateral);
	if(realize_movimiento_lateral || realize_movimiento_rotacional){
		(*juego).jugador.movimientos--;
		(*juego).jugador.movimientos_realizados++;
	}
	if(randall_mueve_papeleo(juego, nivel_jugando) && (realize_movimiento_lateral || realize_movimiento_rotacional)){
		mover_papeleo(juego, nivel_jugando);
	}
	if(aparece_pared_random(juego, (realize_movimiento_lateral || realize_movimiento_rotacional))){
		nueva_pared_random(juego, nivel_jugando);
	}
	while(vacio_abajo(juego, nivel_jugando) && (estado_juego(*juego) == JUGANDO) &&
		 	(estado_nivel((*nivel_jugando).papeleos, (*nivel_jugando).tope_papeleos) == JUGANDO)){
		(*juego).jugador.posicion.fil++;
		bool realize_movimiento = true;
		realizar_interacciones(juego, nivel_jugando, realize_movimiento);
	}
}

//PRE: Los campos de juego.jugador.martillos y juego.jugador.extintores deben estar inicializados.
//POST: Garantiza la obtencion de un movimiento valido para el juego.
void validar_movimiento_del_jugador(juego_t juego, char *movimiento){
	bool movimiento_valido = false;
	while(!movimiento_valido){
		scanf(" %c", movimiento);
		if(((*movimiento) == DIRECCION_DERECHA) || ((*movimiento) == DIRECCION_IZQUIERDA) ||
		   ((*movimiento) == ROTAR_HORARIO) || ((*movimiento) == ROTAR_ANTIHORARIO)){
			movimiento_valido = true;
		}
		if(((*movimiento) == USAR_MARTILLO) && (juego.jugador.martillos > SIN_MARTILLOS)){
			movimiento_valido = true;
		}
		if (((*movimiento) == USAR_EXTINTOR) && (juego.jugador.extintores > SIN_EXTINTORES)){
			movimiento_valido = true;
		}
	}	
}

//PRE: No tiene
//POST: Garantiza la obtencion de una direccion valida para usar martillo.
void validar_direccion_martillo(char* direccion){
	bool direccion_valida = false;
	while(!direccion_valida){
		scanf(" %c", direccion);
		if(((*direccion) == DIRECCION_ARRIBA) || ((*direccion) == DIRECCION_ABAJO) ||
			((*direccion) == DIRECCION_DERECHA) || ((*direccion) == DIRECCION_IZQUIERDA)){
			direccion_valida = true;
		}
	}
}

//PRE: No tiene
//POST: Garantiza la obtencion de una direccion valida para usar extintor.
void validar_direccion_extintor(char* direccion){
	bool direccion_valida = false;
	while(!direccion_valida){
		scanf(" %c", direccion);
		if(((*direccion) == DIRECCION_DERECHA) || ((*direccion) == DIRECCION_IZQUIERDA)
			|| ((*direccion) == DIRECCION_ARRIBA)){
			direccion_valida = true;
		}
	}

}

//PRE: Los campos de juego deben estar inicializados.
//POST: Realiza el movimiento requerido y todas las acciones correspondientes del juego.
void realizar_jugada(juego_t* juego){
	//COMENTARIO: En muchos de los procedimientos y funciones que uso en realizar jugada uso esta referencia
	//				para que el codigo me quede un poco mas prolijo y no lineas tan largas, porque utilizaba
	//				mucho esta linea de codigo, espero que no este mal.... :|
	nivel_t* nivel_jugando = &((*juego).niveles[(*juego).nivel_actual -1]);

	char movimiento;
	validar_movimiento_del_jugador((*juego), &movimiento);
	bool realize_movimiento_lateral = false;
	bool realize_movimiento_rotacional = false;

	if((movimiento == DIRECCION_DERECHA) && !hay_pared(juego, movimiento, nivel_jugando)){
		(*juego).jugador.posicion.col++;
		realize_movimiento_lateral = true;
	}
	if((movimiento == DIRECCION_IZQUIERDA) && !hay_pared(juego, movimiento, nivel_jugando)){
		(*juego).jugador.posicion.col--;
		realize_movimiento_lateral = true;
	}
	if(movimiento == ROTAR_HORARIO){
		rotar_campo_horario(juego, nivel_jugando);
		realize_movimiento_rotacional = true;
	}
	if(movimiento == ROTAR_ANTIHORARIO){
		rotar_campo_antihorario(juego, nivel_jugando);
		realize_movimiento_rotacional = true;
	}
	if(movimiento == USAR_MARTILLO){
		char direccion_martillo;
		validar_direccion_martillo(&direccion_martillo);
		if(hay_pared(juego, direccion_martillo, nivel_jugando) && 
			puedo_martillar(juego, direccion_martillo, nivel_jugando)){
			usar_martillo(juego, direccion_martillo, nivel_jugando);
		}
	}
	if(movimiento == USAR_EXTINTOR){
		char direccion_extintor;
		validar_direccion_extintor(&direccion_extintor);
		if(hay_fuego(juego, direccion_extintor, nivel_jugando)){
			usar_extintor(juego, direccion_extintor, nivel_jugando);
		}
	}
	realizar_acciones_del_juego(juego, realize_movimiento_lateral, realize_movimiento_rotacional, nivel_jugando);
}
