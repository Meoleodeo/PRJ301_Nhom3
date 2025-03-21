package model;

public class Product {
    private int id;
    private int sellerId;
    private String name;
    private String description;
    private int quantity;
    private String imageUrl;
    private double price; // Thêm trường price

    public Product(int id, int sellerId, String name, String description, int quantity, String imageUrl, double price) {
        this.id = id;
        this.sellerId = sellerId;
        this.name = name;
        this.description = description;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
        this.price = price;
    }

    public int getId() { return id; }
    public int getSellerId() { return sellerId; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public int getQuantity() { return quantity; }
    public String getImageUrl() { return imageUrl; }
    public double getPrice() { return price; } // Getter cho price

    public void setId(int id) { this.id = id; }
    public void setSellerId(int sellerId) { this.sellerId = sellerId; }
    public void setName(String name) { this.name = name; }
    public void setDescription(String description) { this.description = description; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setPrice(double price) { this.price = price; } // Setter cho price

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", sellerId=" + sellerId + ", name=" + name + 
               ", description=" + description + ", quantity=" + quantity + 
               ", imageUrl=" + imageUrl + ", price=" + price + '}';
    }
}
