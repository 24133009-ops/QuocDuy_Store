package vn.iotstar.entities;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "products")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productId;

    @Column(name = "productName", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String productName;

    private Double price;

    @Column(columnDefinition = "NVARCHAR(500)")
    private String images;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate;

    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category category;

    public Product() {}

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}