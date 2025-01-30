package model;

import java.nio.DoubleBuffer;

public class Fermata {

    private Integer indice;
    private Tratta tratta;
    private Integer codice;
    private Double longitudine;
    private Double latitudine;

    public Fermata(Integer codice, Double longitudine, Double latitudine) {
        this.codice = codice;
        this.longitudine = longitudine;
        this.latitudine = latitudine;
    }
    public Fermata(Integer codice, Integer indice, Tratta tratta) {
        this.codice = codice;
        this.indice = indice;
        this.tratta = tratta;
    }

    public Integer getCodice() {
        return codice;
    }
    public Integer getIndice() {
        return indice;
    }
    public Double getLatitude() {
        return latitudine;
    }
    public Double getLongitude() {
        return longitudine;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Fermata: ").append(this.codice).append(" -> Indice: ").append(this.indice).append(" -> Tratta: ").append(this.tratta);
        return sb.toString();
    }


}
