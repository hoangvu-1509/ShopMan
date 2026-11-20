package dao;

import model.Customer9;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;

public class CustomerDAO extends DAO {
    
    public CustomerDAO() { 
        super(); 
    }
    
    public boolean checkUsernameAndEmailExist(String username, String email) {
        boolean isExist = false;
        String sql = "SELECT id FROM tblUser9 WHERE username = ? OR email = ?";
        
        try {
            if (con == null || con.isClosed()) {
                return false;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isExist = true; 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isExist; 
    }
    
    public boolean saveCustomer(Customer9 c) {
        boolean isSuccess = false;
        String sqlUser = "INSERT INTO tblUser9 (name, username, password, dateOfBirth, address, email, phone, role, note) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            if (con == null || con.isClosed()) {
                return false;
            }
            
            con.setAutoCommit(false); 
            
            PreparedStatement psUser = con.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, c.getName());
            psUser.setString(2, c.getUsername());
            psUser.setString(3, c.getPassword());
            if (c.getDateOfBirth() != null) {
                psUser.setDate(4, new java.sql.Date(c.getDateOfBirth().getTime()));
            } else {
                psUser.setNull(4, Types.DATE);
            }
            psUser.setString(5, c.getAddress());
            psUser.setString(6, c.getEmail());
            psUser.setString(7, c.getPhone());
            psUser.setString(8, c.getRole() != null ? c.getRole() : "CUSTOMER");
            psUser.setString(9, c.getNote());
            
            psUser.executeUpdate();
            
            ResultSet generatedKeys = psUser.getGeneratedKeys();
            if (generatedKeys.next()) {
                int userId = generatedKeys.getInt(1);
                
                String sqlCustomer = "INSERT INTO tblCustomer9 (tblUser9Id, shippingAddress) VALUES (?, ?)";
                PreparedStatement psCustomer = con.prepareStatement(sqlCustomer);
                psCustomer.setInt(1, userId);
                psCustomer.setString(2, c.getShippingAddress());
                
                psCustomer.executeUpdate();
            }
            
            con.commit();
            isSuccess = true;
            
        } catch (Exception e) {
            try {
                if (con != null) {
                    con.rollback(); 
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        return isSuccess; 
    }
}
