package model;

import java.util.Date;

public class Order {
    private int orderId;
    private int buyerId;
    private int productId;
    private int quantity;
    private String status;
    private Date orderDate;

    public Order(int orderId, int buyerId, int productId, int quantity, String status, Date orderDate) {
        this.orderId = orderId;
        this.buyerId = buyerId;
        this.productId = productId;
        this.quantity = quantity;
        this.status = status;
        this.orderDate = orderDate;
    }

    public int getOrderId() { return orderId; }
    public int getBuyerId() { return buyerId; }
    public int getProductId() { return productId; }
    public int getQuantity() { return quantity; }
    public String getStatus() { return status; }
    public Date getOrderDate() { return orderDate; }

    public void setOrderId(int orderId) { this.orderId = orderId; }
    public void setBuyerId(int buyerId) { this.buyerId = buyerId; }
    public void setProductId(int productId) { this.productId = productId; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setStatus(String status) { this.status = status; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }    
}
