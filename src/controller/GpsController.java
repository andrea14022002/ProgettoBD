package controller;

import model.Gps;
import model.Tratta;
import model.VeicoloinCorsa;

public class GpsController {

    private VeicoloinCorsa veicoloinCorsa;
    private Gps gps;
    private Double coordinateLatitudine;
    private Double coordinateLongitudine;
    private Thread gpsThread;
    private volatile boolean running;

    public GpsController(VeicoloinCorsa veicoloinCorsa) {
        this.veicoloinCorsa = veicoloinCorsa;
        this.running = true;
    }
    public void start() {

        this.gps = new Gps(veicoloinCorsa);
        this.gpsThread = new Thread(() -> {
            while (running) {
                aggiornaPosizione(coordinateLatitudine, coordinateLongitudine);
                checkPoints();
                try {
                    Thread.sleep(1000); // Simula l'aggiornamento ogni secondo
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }
        });
        this.gpsThread.start();
    }

    private void aggiornaPosizione(Double coordinateLatitudine, Double coordinateLongitudine) {
        this.coordinateLatitudine = gps.setCoordinateLatitudine(coordinateLatitudine);
        this.coordinateLongitudine = gps.setCoordinateLongitudine(coordinateLongitudine);
    }

    // Verifica se il veicolo ha superato i punti di partenza o destinazione
    private void checkPoints() {

        VeicoloinCorsa veicoloinCorsa;

        if (coordinateLatitudine.equals(gps.getPartCapolineaLatitudine()) &&  coordinateLongitudine.equals(gps.getCoordinateLongitudine())) {

            //devo mettere procedura che mi aggiorna dato Partito = 1 e mi aggiorna sempre l'indice nel dataBase
            System.out.println("Veicolo ha superato il Capolinea di Partenza.");
        }

        if (coordinateLatitudine.equals(gps.getDestCapolineaLatitudine()) &&  coordinateLongitudine.equals(gps.getDestCapolineaLongitudine())) {
            //procedure che mi aggiorna dato UltimaFermata = TOT.NUMERO
            //reachedDestination = true;
            stop();
            System.out.println("Veicolo ha raggiunto il Capolinea di Destinazione. GPS fermato.");
        }
    }
    public void stop() {
        this.running = false;
    }

    public double getCurrentLatitude() {
        return gps.getCoordinateLatitudine();
    }

    public double getCurrentLongitude() {
            return gps.getCoordinateLongitudine();
    }
    public void stopGPS() {
            stop();
    }

}
