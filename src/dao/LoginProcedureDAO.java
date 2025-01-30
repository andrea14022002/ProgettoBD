package dao;

import exception.DAOException;
import model.Credentials;
import model.Role;

import java.sql.*;

public class LoginProcedureDAO implements GenericProcedureDAO<Credentials> {

    @Override
    public Credentials execute(Object... params) throws DAOException {
        String username = (String) params[0];
        String password = (String) params[1];
        int role;
        String CF;

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call login(?,?,?,?)}");
            cs.setString(1, username);
            cs.setString(2, password);
            cs.registerOutParameter(3, Types.NUMERIC);
            cs.registerOutParameter(4, Types.VARCHAR);
            cs.executeQuery();
            role = cs.getInt(3);
            CF = cs.getString(4);
        } catch(SQLException e) {
            throw new DAOException("Login error: " + e.getMessage());
        }

        return new Credentials(username, password, Role.fromInt(role), CF);
    }
}
