package controller;

import dao.ConnectionFactory;
import exception.DAOException;
import model.*;
import view.ViaggiatoreView;

import java.io.IOException;
import java.sql.SQLException;

public class ViaggiatoreController {

    public void start() {
        try {
            ConnectionFactory.changeRole(Role.VIAGGIATORE);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
        while(true) {
            int choice;
            try {
                choice = ViaggiatoreView.showMenu();
            } catch(IOException e) {
                throw new RuntimeException(e);
            }

            switch(choice) {
                case 1 -> listaVeicoli();
                case 2 -> distanzaVeicolo();
                case 3 -> convalidaBiglietto();
                case 4 -> listaTratte();
                case 5 -> System.exit(0);
                default -> throw new RuntimeException("Opzione non valida");
            }
        }
    }

    public void listaVeicoli() {

        VeicoloinCorsa veicoloinCorsa;
        try {
            veicoloinCorsa = new ListaVeicoliProcedureDAO().execute();
            System.out.println(veicoloinCorsa);
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void distanzaVeicolo() {

        VeicoloinCorsa veicoloinCorsa;
        try {
            veicoloinCorsa = ViaggiatoreView.distanzaVeicolo();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new DistanzaVeicoloProcedureDAO().execute(veicoloinCorsa);
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void convalidaBiglietto() {

        Biglietto biglietto;
        try {
            biglietto = ViaggiatoreView.convalidaBiglietto();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
       try {
            new ConvalidaBigliettoProcedureDAO().execute(biglietto);
            System.out.println("Operazione terminata con successo.");
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void listaTratte() {

        VeicoloinCorsa veicoloinCorsa;
        try {
            veicoloinCorsa = new ListaTratteProcedureDAO().execute();
            System.out.println(veicoloinCorsa);
        } catch(DAOException e) {
            System.out.println(e.getMessage());
        }
    }
}
