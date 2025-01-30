package dao;

import dao.ConnectionFactory;
import dao.GenericProcedureDAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GestoreDao {

    Connection connection = null;
    CallableStatement callableStatement = null;
    ResultSet resultSet = null;

    public void elencoScadenze() {
        try {
            connection = ConnectionFactory.getConnection();
            callableStatement = connection.prepareCall("call elenco_scadenze_patente()");
            resultSet = callableStatement.executeQuery();
            while(resultSet.next()) {
                System.out.println(resultSet.getString("CF") + " " + resultSet.getDate("ScadenzaPatente"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
