#ifndef GESTION_CAJAS_H_
#define GESTION_CAJAS_H_
#include "lista.h"

typedef struct gestion_cajas gestion_cajas_t;

gestion_cajas_t *cargar_cajas(int argc, char *argv[]);

void mostrar_inventario(gestion_cajas_t *gestion);

void cargar_otra_caja(gestion_cajas_t *gestion, const char *nueva_clave);

void combinar_cajas(gestion_cajas_t *gestion, const char *nombre_caja1, const char *nombre_caja2, const char *nueva_caja);

void mostrar_caja(gestion_cajas_t *gestion, const char *caja_mostrar);

void buscar_caja(gestion_cajas_t *gestion, const char *pokemon);

void salir_del_programa(gestion_cajas_t *gestion);

#endif // GESTION_CAJAS_H_