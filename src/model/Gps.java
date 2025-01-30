package model;

public class Gps {

    private Double coordinateLatitudine;
    private Double coordinateLongitudine;
    private Double destCapolineaLatitudine;
    private Double destCapolineaLongitudine;
    private Double partCapolineaLatitudine;
    private Double partCapolineaLongitudine;
    private Tratta tratta;


    public Gps (VeicoloinCorsa veicoloinCorsa) {
        this.tratta = veicoloinCorsa.getTratta();
        this.partCapolineaLatitudine = tratta.getCapolineaPartenza().getLatitude();
        this.partCapolineaLongitudine = tratta.getCapolineaPartenza().getLongitude();
        this.destCapolineaLatitudine = tratta.getCapolineaArrivo().getLatitude();
        this.destCapolineaLongitudine = tratta.getCapolineaArrivo().getLongitude();
    }

    public Double getCoordinateLatitudine() {
        return coordinateLatitudine;
    }

    public Double getCoordinateLongitudine() {
        return coordinateLongitudine;
    }

    public Double setCoordinateLatitudine(Double coordinateLatitudine) {
        this.coordinateLatitudine = coordinateLatitudine;
        return this.coordinateLatitudine;
    }

    public Double setCoordinateLongitudine(Double coordinateLongitudine) {
        this.coordinateLongitudine = coordinateLongitudine;
        return this.coordinateLongitudine;
    }

    public Double getDestCapolineaLatitudine() {
        return destCapolineaLatitudine;
    }

    public Double getDestCapolineaLongitudine() {
        return destCapolineaLongitudine;
    }

    public Double getPartCapolineaLatitudine() {
        return partCapolineaLatitudine;
    }

    public Double getPartCapolineaLongitudine() {
        return partCapolineaLongitudine;
    }

    public String toString() {
        return "Coordinate: " + this.coordinateLatitudine + ", " + this.coordinateLongitudine;
    }
}

