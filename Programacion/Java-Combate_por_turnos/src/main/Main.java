import java.util.ArrayList;
import java.util.List;

public class Main {
    
    public static void main(String[] args){

        Bando bandoUno; 
        Bando bandoDos;
        Combate unCombate = new Combate();
        ArrayList<Personaje> personajesBandoUno;
        ArrayList<Personaje> personajesBandoDos;

        System.out.println("Realizaremos combates y veremos el resultado");

        personajesBandoUno = new ArrayList<>(List.of(new Guerrero()));
        personajesBandoDos = new ArrayList<>(List.of(new Mago()));
        bandoUno = new Bando(personajesBandoUno, "Bando Guerrero");
        bandoDos = new Bando(personajesBandoDos, "Bando Mago");
        unCombate.combateEntreBandos(bandoUno, bandoDos);
        System.out.println("\nCombate entre bando: " + bandoUno.nombreBando() + " y " + bandoDos.nombreBando());
        System.out.println("El resultado del combate es Victoria del bando: " + unCombate.resultadoDeCombate());
        
        personajesBandoUno = new ArrayList<>(List.of(new Guerrero()));
        personajesBandoDos = new ArrayList<>(List.of(new Mago()));
        bandoUno = new Bando(personajesBandoUno, "Bando Guerrero");
        bandoDos = new Bando(personajesBandoDos, "Bando Mago");
        unCombate.combateEntreBandos(bandoDos, bandoUno);
        System.out.println("\nCombate entre bando: " + bandoUno.nombreBando() + " y " + bandoDos.nombreBando());
        System.out.println("El resultado del combate es Victoria del bando: " + unCombate.resultadoDeCombate());

        personajesBandoUno = new ArrayList<>(List.of(new Guerrero()));
        personajesBandoDos = new ArrayList<>(List.of(new Mago(), new Mago()));
        bandoUno = new Bando(personajesBandoUno, "Bando 1 Guerrero");
        bandoDos = new Bando(personajesBandoDos, "Bando 2 Mago");
        unCombate.combateEntreBandos(bandoDos, bandoUno);
        System.out.println("\nCombate entre bando: " + bandoUno.nombreBando() + " y " + bandoDos.nombreBando());
        System.out.println("El resultado del combate es Victoria del bando: " + unCombate.resultadoDeCombate());  
    }
}
