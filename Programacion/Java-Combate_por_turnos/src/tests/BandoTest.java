import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;
import org.junit.Test;
import java.util.ArrayList;
import java.util.List;

public class BandoTest {
    
    @Test
    public void unBandoAtacaAlOtro(){

        ArrayList<Personaje> personajesBandoUno = new ArrayList<>(List.of(new Guerrero()));
        ArrayList<Personaje> personajesBandoDos = new ArrayList<>(List.of(new Guerrero()));
        Bando bandoUno = new Bando(personajesBandoUno, "Bando uno");
        Bando bandoDos = new Bando(personajesBandoDos, "Bando dos");

        bandoUno.atacar(bandoDos);
        bandoDos.atacar(bandoUno);

        assertEquals(20, personajesBandoUno.get(0).getVida());
        assertEquals(20, personajesBandoDos.get(0).getVida());
    }

    @Test
    public void cuandoUnPersonajeNoTieneVidaEsRetiradoDelBando(){

        Guerrero unGuerreroSinVida = new Guerrero();
        ArrayList<Personaje> personajesBandoUno = new ArrayList<>(List.of(new Guerrero()));
        ArrayList<Personaje> personajesBandoDos = new ArrayList<>(List.of(unGuerreroSinVida));
        Bando bandoUno = new Bando(personajesBandoUno, "Bando uno");
        Bando bandoDos = new Bando(personajesBandoDos, "Bando dos");

        bandoUno.atacar(bandoDos);
        bandoUno.atacar(bandoDos);
        bandoUno.atacar(bandoDos);

        assertEquals(false, unGuerreroSinVida.estaConVida());
        assertEquals(false, bandoDos.tienePersonajesConVida());
    }

    @Test
    public void unBandoNoPuedeEmpezarVacio(){

        ArrayList<Personaje> listaBando = new ArrayList<>();
        Throwable exeption = assertThrows(IllegalArgumentException.class, () -> {
            new Bando(listaBando, "");
        });
        
        assertEquals(Bando.listaPersonajesVaciaError(), exeption.getMessage());
    }
}
