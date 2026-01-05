import java.util.ArrayList;
import java.util.Random;

public class Bando {

    ArrayList<Personaje> personajes = new ArrayList<>();
    String nombre;

    public static String listaPersonajesVaciaError(){
        return "No se puede iniciar un bando sin personajes";
    }

    public Bando(ArrayList<Personaje> unaListaDePersonajes, String unNombreDeBando){
        
        if(unaListaDePersonajes.isEmpty()){
            throw new IllegalArgumentException(Bando.listaPersonajesVaciaError());
        }
        personajes = unaListaDePersonajes;
        this.nombre = unNombreDeBando;
    }

    public ArrayList<Personaje> getPersonajesDeBando(){
        return this.personajes;
    }

    public boolean tienePersonajesConVida(){
        return !personajes.isEmpty();
    }

    public Personaje unPersonajeAleatorioDeBando(){
        int indiceAleatorio = (new Random()).nextInt(personajes.size());
        return personajes.get(indiceAleatorio);
    }

    public void retirarPersonajeSinVida(Personaje personajeARetirar){
        personajes.remove(personajeARetirar);
    }

    public void atacar(Bando bandoEnemigo){

        Personaje personajeAtacado = bandoEnemigo.unPersonajeAleatorioDeBando();
        this.unPersonajeAleatorioDeBando().atacar(personajeAtacado);
        if(!personajeAtacado.estaConVida()){
            bandoEnemigo.retirarPersonajeSinVida(personajeAtacado);
        }
    }

    public String nombreBando(){
        
        return this.nombre; 
    }
}
