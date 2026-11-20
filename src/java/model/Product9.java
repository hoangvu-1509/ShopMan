package model;

import java.io.Serializable;

public class Product9 implements Serializable {
    private int id;
    private String productName;
    private String description;
    private String brand;

    public Product9() {
    }

    public Product9(int id, String productName, String description, String brand) {
        this.id = id;
        this.productName = productName;
        this.description = description;
        this.brand = brand;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }
}
