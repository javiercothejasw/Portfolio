import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

public class CombateTest {
    

    @Test
    public void combateUnoContraUnoGanaElQueEmpiezaPrimero(){

        ArrayList<Personaje> listaBandoGanador = new ArrayList<>(List.of(new Guerrero()));
        ArrayList<Personaje> listaBandoDerrotado = new ArrayList<>(List.of(new Mago()));
        Bando bandoGanador = new Bando(listaBandoGanador, "Bando uno");
        Bando bandoDerrotado = new Bando(listaBandoDerrotado, "Bando dos");
        Combate unCombate = new Combate();
        unCombate.combateEntreBandos(bandoGanador, bandoDerrotado);

        assertEquals("Bando uno", unCombate.resultadoDeCombate());
    }

    @Test
    public void bandoDerrotadNoTienePersonajesConVida(){

        ArrayList<Personaje> listaBandoGanador = new ArrayList<>(List.of(new Guerrero(), new Mago()));
        ArrayList<Personaje> listaBandoDerrotado = new ArrayList<>(List.of(new Guerrero()));
        Bando bandoGanador = new Bando(listaBandoGanador, "Bando uno");
        Bando bandoDerrotado = new Bando(listaBandoDerrotado, "Bando dos");
        Combate unCombate = new Combate();
        unCombate.combateEntreBandos(bandoGanador, bandoDerrotado);

        assertEquals(false, bandoDerrotado.tienePersonajesConVida());
    }

    @Test
    public void bandoConMasPersonajesGanaElCombate(){

        ArrayList<Personaje> listaConDosPersonaje = new ArrayList<>(List.of(new Guerrero(), new Mago()));
        ArrayList<Personaje> listaConUnPersonaje = new ArrayList<>(List.of(new Guerrero()));
        Bando bandoConDosPersonaje = new Bando(listaConDosPersonaje, "Bando con dos personaje");
        Bando bandoConUnPersonaje = new Bando(listaConUnPersonaje, "Bando con un personaje");
        Combate unCombate = new Combate();
        unCombate.combateEntreBandos(bandoConDosPersonaje, bandoConUnPersonaje);
        
        assertEquals("Bando con dos personaje", unCombate.resultadoDeCombate());
    }
}
