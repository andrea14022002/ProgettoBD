package model;

import java.util.ArrayList;
import java.util.List;

public class Tratta {

    Integer idTratta;
    Fermata capolineaPartenza;
    Fermata capolineaArrivo;
    private List<Fermata> fermate = new ArrayList<>();

    public Tratta(Integer idTratta, Fermata capolineaPartenza, Fermata capolineaArrivo) {
        this.idTratta = idTratta;
        this.capolineaPartenza = capolineaPartenza;
        this.capolineaArrivo = capolineaArrivo;
    }

    public Fermata getCapolineaPartenza() {
        return capolineaPartenza;
    }
    public Fermata getCapolineaArrivo() {
        return capolineaArrivo;
    }

    public Integer getIdTratta() {
        return idTratta;
    }

    public List<Fermata> getFermate() {
        return fermate;
    }

    public Fermata getFermata(Integer indice) {
        return fermate.get(indice);
    }

    public void addFermata(Fermata fermata) {
        fermate.add(fermata);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Tratta : "+ this.idTratta +" da "+ this.capolineaPartenza +" a "+ this.capolineaArrivo +"\n");
        for(Fermata fermata : fermate) {
            sb.append(fermata).append('-');
        }
        return sb.toString();
    }
}
