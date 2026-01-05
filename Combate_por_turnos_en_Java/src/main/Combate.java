
public class Combate {
    
    Bando bandoUno;
    Bando bandoDos;
    String resultado;


    public void combateEntreBandos(Bando bandoUno, Bando bandoDos){
        
        this.bandoUno = bandoUno;
        this.bandoUno = bandoUno;
        this.combatirBandos(bandoUno, bandoDos);
    }

    private void combatirBandos(Bando bandoAtacante, Bando bandoDefensor){

        if(!bandoAtacante.tienePersonajesConVida()){
            resultado = bandoDefensor.nombreBando();
            return;
        }
        bandoAtacante.atacar(bandoDefensor);
        combatirBandos(bandoDefensor, bandoAtacante);
    }
    
    public String resultadoDeCombate(){

        return this.resultado;
    }
}
