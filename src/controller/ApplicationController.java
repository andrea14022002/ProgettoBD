package controller;

import model.Credentials;

public class ApplicationController {

    public void start() {
        LoginController loginController = new LoginController();
        loginController.start();
        Credentials cred = loginController.getCred();

        if(cred.getRole() == null) {
            throw new RuntimeException("Invalid credentials");
        }

        switch(cred.getRole()) {
            case CONDUCENTE -> new ConducenteController().start(cred.getId());
            case GESTORE -> new GestoreController().start();
            case VIAGGIATORE -> new ViaggiatoreController().start();
            default -> throw new RuntimeException("Credentials not valid.");
        }
    }
}
