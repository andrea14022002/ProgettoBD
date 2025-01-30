package model;

import java.util.Date;

public class Veicolo {

    Integer matricola;
    Date dataAcquisto;

    public Veicolo(Integer matricola, Date dataAcquisto) {
        this.matricola = matricola;
        this.dataAcquisto = dataAcquisto;
    }

    public Integer getMatricola() {
        return matricola;
    }

    public Date getDataAcquisto() {
        return dataAcquisto;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Veicolo: ").append(this.matricola).append(" -> Data Acquisto: ").append(this.dataAcquisto);
        return sb.toString();
    }
}
