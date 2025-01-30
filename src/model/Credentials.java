package model;


public class Credentials {

    private final String username;
    private final String password;
    private final Role role;
    private final String id;

    public Credentials(String username, String password, Role role, String id) {

        this.username = username;
        this.password = password;
        this.role = role;
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public Role getRole() {
        return role;
    }

    public String getId() {
        return id;
    }
}
