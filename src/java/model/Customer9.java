package model;

public class Customer9 extends User9 {
    private String shippingAddress;

    public Customer9() {
        super();
        this.role = "CUSTOMER";
    }

    public Customer9(String shippingAddress) {
        super();
        this.shippingAddress = shippingAddress;
        this.role = "CUSTOMER";
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
}
