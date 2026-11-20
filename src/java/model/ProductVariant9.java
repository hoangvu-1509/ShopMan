package model;

import java.io.Serializable;

public class ProductVariant9 implements Serializable {
    protected int id;
    protected String SKUCode;
    protected String color;
    protected String size;
    protected float price;
    protected int stockQuantity;
    protected Product9 product;

    public ProductVariant9() {
    }

    public ProductVariant9(int id, String SKUCode, String color, String size, float price, int stockQuantity, Product9 product) {
        this.id = id;
        this.SKUCode = SKUCode;
        this.color = color;
        this.size = size;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSKUCode() {
        return SKUCode;
    }

    public void setSKUCode(String SKUCode) {
        this.SKUCode = SKUCode;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public Product9 getProduct() {
        return product;
    }

    public void setProduct(Product9 product) {
        this.product = product;
    }
}
