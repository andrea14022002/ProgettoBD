package model;

import java.sql.Time;
import java.util.Date;

public class VeicoloinCorsa {

    String giorno;
    Time ora;
    Tratta tratta;
    Veicolo veicolo;
    String conducente;

    public VeicoloinCorsa(String giorno, Time ora, Tratta tratta, String conducente, Veicolo veicolo){
        this.giorno = giorno;
        this.ora = ora;
        this.conducente = conducente;
        this.tratta = tratta;
        this.veicolo = veicolo;
    }

    public String getGiorno() {
        return giorno;
    }

    public Time getOra() {
        return ora;
    }

    public Tratta getTratta() {
        return tratta;
    }

    public Veicolo getVeicolo() {
        return veicolo;
    }

    public String getConducente() {
        return conducente;
    }

}
