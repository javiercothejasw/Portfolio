import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class PersonajeTest {

	@Test
	public void guerreroTiene30VidaY10Ataque() {
		
		Guerrero unGuerrero = new Guerrero();
		
		assertEquals(30, unGuerrero.getVida());
		assertEquals(10, unGuerrero.ataque);
	}
	
	@Test
	public void magoTiene20VidaY15Ataque() {
		
		Mago unMago = new Mago();
		
		assertEquals(20, unMago.getVida());
		assertEquals(15, unMago.ataque);
	}

	@Test
	public void guerreroAlAtacarHace10DeDaño(){

		Guerrero unGuerrero = new Guerrero();
		Mago unMago = new Mago();

		unGuerrero.atacar(unMago);
		assertEquals(10, unMago.getVida());
	}
	
	@Test
	public void magoAlAtacarHace15DeDaño(){
		
		Guerrero unGuerrero = new Guerrero();
		Mago unMago = new Mago();

		unMago.atacar(unGuerrero);
		assertEquals(15, unGuerrero.getVida());
	}
}