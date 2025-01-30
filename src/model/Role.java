package model;

public enum Role {
    CONDUCENTE(1),
    GESTORE(2),
    VIAGGIATORE(3);

    private final int num;

    private Role(int num) {
        this.num = num;
    }

    public static Role fromInt(int num) {
        for (model.Role type : values()) {
            if (type.getNum() == num) {
                return type;
            }
        }
        return null;
    }

    public int getNum() {
            return num;
        }
    }

