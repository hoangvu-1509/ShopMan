package dao;

import model.Customer9;
import model.Order9;
import model.OrderDetail9;
import model.Product9;
import model.ProductRevenueStat9;
import model.ProductVariant9;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class StatisticsDAO extends DAO {

    public StatisticsDAO() {
        super();
    }

    public List<ProductRevenueStat9> getRevenueStatistics(String keyword, String sortRevenue, String sortQuantity) {
        List<ProductRevenueStat9> list = new ArrayList<>();

        if (con == null) {
            return list;
        }

        try {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT pv.id, pv.SKUCode, pv.color, pv.size, pv.price, p.productName, ")
               .append("COALESCE(SUM(od.quantity), 0) AS totalQuantitySold, ")
               .append("COALESCE(SUM(od.totalPrice), 0) AS totalRevenue ")
               .append("FROM tblProductVariant9 pv ")
               .append("JOIN tblProduct9 p ON pv.tblProduct9Id = p.id ")
               .append("LEFT JOIN tblOrderDetail9 od ON pv.id = od.tblProductVariant9Id ")
               .append("WHERE 1=1 ");

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append("AND (p.productName LIKE ? OR pv.SKUCode LIKE ?) ");
            }

            sql.append("GROUP BY pv.id, pv.SKUCode, pv.color, pv.size, pv.price, p.productName ");

            if ("desc".equalsIgnoreCase(sortRevenue)) {
                sql.append("ORDER BY totalRevenue DESC ");
            } else if ("asc".equalsIgnoreCase(sortRevenue)) {
                sql.append("ORDER BY totalRevenue ASC ");
            } else if ("desc".equalsIgnoreCase(sortQuantity)) {
                sql.append("ORDER BY totalQuantitySold DESC ");
            } else if ("asc".equalsIgnoreCase(sortQuantity)) {
                sql.append("ORDER BY totalQuantitySold ASC ");
            } else {
                sql.append("ORDER BY pv.id ASC ");
            }

            PreparedStatement ps = con.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, kw);
                ps.setString(paramIndex++, kw);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductRevenueStat9 stat = new ProductRevenueStat9();
                stat.setId(rs.getInt("id"));
                stat.setSKUCode(rs.getString("SKUCode"));
                stat.setColor(rs.getString("color"));
                stat.setSize(rs.getString("size"));
                stat.setPrice(rs.getFloat("price"));

                Product9 p = new Product9();
                p.setProductName(rs.getString("productName"));
                stat.setProduct(p);

                stat.setTotalQuantitySold(rs.getInt("totalQuantitySold"));
                stat.setTotalRevenue(rs.getFloat("totalRevenue"));

                list.add(stat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<OrderDetail9> getTransactionDetails(String skuCode, String keyword, Date startDate, Date endDate, String sortBy) {
        List<OrderDetail9> list = new ArrayList<>();

        if (con == null) {
            return list;
        }

        try {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT od.id, od.quantity, od.unitPrice, od.totalPrice, ")
               .append("o.id AS orderId, o.orderDate, o.shippingFee, ")
               .append("u.name AS customerName, pv.SKUCode, pv.price, p.productName ")
               .append("FROM tblOrderDetail9 od ")
               .append("JOIN tblOrder9 o ON od.tblOrder9Id = o.id ")
               .append("JOIN tblCustomer9 c ON o.tblCustomer9tblUser9Id = c.tblUser9Id ")
               .append("JOIN tblUser9 u ON c.tblUser9Id = u.id ")
               .append("JOIN tblProductVariant9 pv ON od.tblProductVariant9Id = pv.id ")
               .append("JOIN tblProduct9 p ON pv.tblProduct9Id = p.id ")
               .append("WHERE pv.SKUCode = ? ");

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append("AND (u.name LIKE ? OR CONCAT('HD', o.id) LIKE ?) ");
            }
            if (startDate != null) {
                sql.append("AND o.orderDate >= ? ");
            }
            if (endDate != null) {
                sql.append("AND o.orderDate <= ? ");
            }

            if ("oldest".equalsIgnoreCase(sortBy)) {
                sql.append("ORDER BY o.orderDate ASC, o.id ASC ");
            } else {
                sql.append("ORDER BY o.orderDate DESC, o.id DESC ");
            }

            PreparedStatement ps = con.prepareStatement(sql.toString());
            int idx = 1;
            ps.setString(idx++, skuCode);

            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(idx++, kw);
                ps.setString(idx++, kw);
            }
            if (startDate != null) {
                ps.setDate(idx++, new java.sql.Date(startDate.getTime()));
            }
            if (endDate != null) {
                ps.setDate(idx++, new java.sql.Date(endDate.getTime()));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail9 od = new OrderDetail9();
                od.setId(rs.getInt("id"));
                od.setQuantity(rs.getInt("quantity"));
                od.setUnitPrice(rs.getFloat("unitPrice"));
                od.setTotalPrice(rs.getFloat("totalPrice"));

                Order9 o = new Order9();
                o.setId(rs.getInt("orderId"));
                o.setOrderDate(rs.getDate("orderDate"));
                o.setShippingFee(rs.getFloat("shippingFee"));

                Customer9 c = new Customer9();
                c.setName(rs.getString("customerName"));
                o.setCustomer(c);
                od.setOrder(o);

                ProductVariant9 pv = new ProductVariant9();
                pv.setSKUCode(rs.getString("SKUCode"));
                pv.setPrice(rs.getFloat("price"));
                Product9 p = new Product9();
                p.setProductName(rs.getString("productName"));
                pv.setProduct(p);
                od.setProductVariant(pv);

                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
