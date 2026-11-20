package model;

import java.util.Date;

public class ProductRevenueStat9 extends ProductVariant9 {
    private Date startDate;
    private Date endDate;
    private int totalQuantitySold;
    private float totalRevenue;

    public ProductRevenueStat9() {
        super();
    }

    public ProductRevenueStat9(Date startDate, Date endDate, int totalQuantitySold, float totalRevenue) {
        super();
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalQuantitySold = totalQuantitySold;
        this.totalRevenue = totalRevenue;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getTotalQuantitySold() {
        return totalQuantitySold;
    }

    public void setTotalQuantitySold(int totalQuantitySold) {
        this.totalQuantitySold = totalQuantitySold;
    }

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
