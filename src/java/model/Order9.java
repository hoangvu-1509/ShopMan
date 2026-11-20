package model;

import java.io.Serializable;
import java.util.Date;

public class Order9 implements Serializable {
    private int id;
    private Date orderDate;
    private float totalAmount;
    private String note;
    private String orderStatus;
    private float shippingFee;
    private Customer9 customer;

    public Order9() {
    }

    public Order9(int id, Date orderDate, float totalAmount, String note, String orderStatus, float shippingFee, Customer9 customer) {
        this.id = id;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.note = note;
        this.orderStatus = orderStatus;
        this.shippingFee = shippingFee;
        this.customer = customer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public float getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(float shippingFee) {
        this.shippingFee = shippingFee;
    }

    public Customer9 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer9 customer) {
        this.customer = customer;
    }
}
