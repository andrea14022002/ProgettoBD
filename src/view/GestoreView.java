package view;

import java.io.IOException;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.InputMismatchException;
import java.util.Scanner;

public class GestoreView {
    public static int showMenu() throws IOException {
        System.out.println("********************************");
        System.out.println("*           BENVENUTO          *");
        System.out.println("********************************");
        System.out.println("Quale operazione vuoi effettuare?\n");
        System.out.println("1) Aggiungi orario partenza Veicolo.");
        System.out.println("2) Aggiorna conducente a Veicolo in corsa.");
        System.out.println("3) Aggiungi fermata in una tratta.");
        System.out.println("4) Aggiungi tratta.");
        System.out.println("5) Registra conducente.");
        System.out.println("6) Elenco scadennze patente dei conducenti.");
        System.out.println("7) Esci");

        Scanner input = new Scanner(System.in);
        int choice;

        while (true) {
            try{
                System.out.println("Digita numero dell'operazione: ");
                choice = input.nextInt();
                if (choice >= 1 && choice <= 7) {
                    break;
                } else {
                    throw new InputMismatchException();
                }
            } catch (InputMismatchException e) {
                System.out.println("Numero non valido. Riprova.");
                input.next();
            }
        }
        return choice;
    }
}
