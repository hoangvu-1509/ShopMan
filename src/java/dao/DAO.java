package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    protected Connection con;

    public DAO() {
        
        String dbUrl = "jdbc:mysql://localhost:3306/shopman_db?useUnicode=true&characterEncoding=UTF-8";
        
        String dbClass = "com.mysql.cj.jdbc.Driver"; 
        
        try {
            Class.forName(dbClass);
            
            con = DriverManager.getConnection(dbUrl, "root", "123456"); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
