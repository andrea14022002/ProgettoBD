package view;

import java.io.IOException;
import java.util.Scanner;

public class ViaggiatoreView {

    public static int showMenu() throws IOException {
        System.out.println("*********************************");
        System.out.println("*           BENVENUTO           *");
        System.out.println("*********************************\n");
        System.out.println("Quale operazione vuoi effettuare?\n");
        System.out.println("1) Lista veicoli in corsa passanti per la tua fermata.");
        System.out.println("2) Distanza Veicolo in Corsa dalla tua fermata.");
        System.out.println("3) Convalida biglietto.");
        System.out.println("4) Lista giornaliera tratte passanti per la tua fermata.");
        System.out.println("5) Esci");


        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Digita numero dell'operazione: ");
            choice = input.nextInt();
            if (choice >= 1 && choice <= 4) {
                break;
            }
            System.out.println("Numero non valido. Riprova.");
        }

        return choice;
    }

}
