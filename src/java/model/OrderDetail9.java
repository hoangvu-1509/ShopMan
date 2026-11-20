package model;

import java.io.Serializable;

public class OrderDetail9 implements Serializable {
    private int id;
    private int quantity;
    private float unitPrice;
    private float totalPrice;
    private Order9 order;
    private ProductVariant9 productVariant;

    public OrderDetail9() {
    }

    public OrderDetail9(int id, int quantity, float unitPrice, float totalPrice, Order9 order, ProductVariant9 productVariant) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.order = order;
        this.productVariant = productVariant;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Order9 getOrder() {
        return order;
    }

    public void setOrder(Order9 order) {
        this.order = order;
    }

    public ProductVariant9 getProductVariant() {
        return productVariant;
    }

    public void setProductVariant(ProductVariant9 productVariant) {
        this.productVariant = productVariant;
    }
}
