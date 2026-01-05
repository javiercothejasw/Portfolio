
public abstract class Personaje {

    int vida;
    int ataque;

    public int getVida(){
        return this.vida;
    }

    public void setVida(int vida){
        this.vida = vida;
    }

    public void atacar(Personaje unPersonaje){
                
        int vidaActualizada = unPersonaje.getVida() - this.ataque;
        unPersonaje.setVida(vidaActualizada);
    }

    public boolean estaConVida(){
        
        return this.getVida() > 0; 
    }

    public abstract String nombrePersonaje();

}