package view;

import model.Credentials;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class LoginView {

    public static Credentials authenticate() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("insert username: ");
        String username = reader.readLine();
        System.out.print("insert password: ");
        String password = reader.readLine();

        return new Credentials(username, password, null, null);
    }

}
