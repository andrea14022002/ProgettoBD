package controller;

import dao.ConnectionFactory;
import exception.DAOException;
import model.*;
import view.ConducenteView;

import java.io.IOException;
import java.sql.SQLException;

public class ConducenteController {

    private String CF;

    public void start(String CF) {
        try {
            ConnectionFactory.changeRole(Role.CONDUCENTE);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        this.CF = CF;
        while (true) {
            int choice;
            try {
                choice = ConducenteView.showMenu();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            switch (choice) {
                case 1 -> prossimoOrarioPartenza();
                case 2 -> aggiornaDatiPatente();
                case 3 -> elencoOrarioLavorativo();
                case 4 -> System.exit(0);
                default -> throw new RuntimeException("Opzione non valida.");
            }
        }
    }

    public void prossimoOrarioPartenza() {

        VeicoloinCorsa orarioPartenza;
        try {
            orarioPartenza = new OrarioPartenzaProcedureDAO().execute(this.CF);
            System.out.println(orarioPartenza);
        } catch (DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void aggiornaDatiPatente() {

        Conducente conducente;
        try {
            conducente = ConducenteView.aggiornaDatiPatente(this.CF);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new AggiornaDatiPatenteProcedureDAO().execute(conducente);
            System.out.println("Operazione terminata con successo.");
        } catch (DAOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void elencoOrarioLavorativo() {
        VeicoloinCorsa orarioLavorativo;
        try {
            orarioLavorativo = new OrarioLavorativoProcedureDAO().execute(this.CF);
            System.out.println(orarioLavorativo);
        } catch (DAOException e) {
            System.out.println(e.getMessage());
        }
    }
}

