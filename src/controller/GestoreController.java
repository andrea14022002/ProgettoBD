package controller;

import dao.ConnectionFactory;
import exception.DAOException;
import model.Conducente;
import model.Fermata;
import model.Tratta;
import model.VeicoloinCorsa;
import model.Role;
import view.GestoreView;

import java.io.IOException;
import java.sql.SQLException;

public class GestoreController {

    public void start() {
        try {
            ConnectionFactory.changeRole(Role.GESTORE);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
        while(true) {
            int choice;
            try {
                choice = GestoreView.showMenu();
            } catch(IOException e) {
                throw new RuntimeException(e);
            }

            switch(choice) {
                case 1 -> aggiungiOrarioPartenzaVeicolo();
                case 2 -> assegnaConducenteaVeicolo();
                case 3 -> aggiungiFermataTratta();
                case 4 -> aggiungiTratta();
                case 5 -> registraConducente();
                case 6 -> elencoScedenzaPatente();
                case 7 -> System.exit(0);
                default -> throw new RuntimeException("Opzione non valida");
            }
        }
    }

    public void aggiungiOrarioPartenzaVeicolo() {

        VeicoloinCorsa veicoloinCorsa;

        try {
            veicoloinCorsa = GestoreView.aggiungiOrarioPartenzaVeicolo();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new AggiungiOrarioPartenzaProcedureDAO().execute(veicoloinCorsa);
            System.out.println("Operazione terminata con successo.");
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void assegnaConducenteaVeicolo() {

        VeicoloinCorsa veicoloinCorsa;

        try {
            veicoloinCorsa = GestoreView.assegnaConducenteaVeicolo();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new AssegnaConducenteaVeicoloProcedureDAO().execute(veicoloinCorsa);
            System.out.println("Operazione terminata con successo.");
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void aggiungiFermataTratta() {

        Fermata fermata;
        try {
            fermata = GestoreView.aggiungiFermataTratta();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new AggiungiFermataTrattaProcedureDAO().execute(fermata);
            System.out.println("Operazione terminata con successo.");
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void aggiungiTratta() {

        Tratta tratta;
        try {
            tratta = GestoreView.aggiungiTratta();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new AggiungiTrattaProcedureDAO().execute(tratta);
            System.out.println("Operazione terminata con successo.");
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void registraConducente() {
        Conducente conducente;
        try {
            conducente = GestoreView.registraConducente();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new RegistraConducenteProcedureDAO().execute(conducente);
            System.out.println("Operazione terminata con successo.");
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void elencoScedenzaPatente() {
        Conducente listaScadenzePatente;

        try {
            listaScadenzePatente = new ListaScadenzePatente().execute();
            System.out.println(listaScadenzePatente);
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }
}
