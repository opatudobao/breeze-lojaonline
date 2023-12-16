package com.onlinecloth.pojo;

public class Product {
    private int productId, productQuantity, categoryId, clothId;
    private String productTitle, productDescription, productPhoto, productFor;

    public Product() {

    }

    public Product(int productQuantity, int categoryId, String productTitle, String productDescription,
            String productPhoto) {
        super();
        this.productQuantity = productQuantity;
        this.categoryId = categoryId;
        this.productTitle = productTitle;
        this.productDescription = productDescription;
        this.productPhoto = productPhoto;
    }

    public Product(int productId, int productQuantity, int categoryId, String productTitle, String productDescription,
            String productPhoto) {
        super();
        this.productId = productId;
        this.productQuantity = productQuantity;
        this.categoryId = categoryId;
        this.productTitle = productTitle;
        this.productDescription = productDescription;
        this.productPhoto = productPhoto;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(int productQuantity) {
        this.productQuantity = productQuantity;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductTitle() {
        return productTitle;
    }

    public void setProductTitle(String productTitle) {
        this.productTitle = productTitle;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public String getProductPhoto() {
        return productPhoto;
    }

    public void setProductPhoto(String productPhoto) {
        this.productPhoto = productPhoto;
    }

    public String getProductFor() {
        return productFor;
    }

    public void setProductFor(String productFor) {
        this.productFor = productFor;
    }

    public int getClothId() {
        return clothId;
    }

    public void setClothId(int clothId) {
        this.clothId = clothId;
    }

    @Override
    public String toString() {
        return "Product [productId=" + productId + ", productQuantity=" + productQuantity + ", categoryId=" + categoryId
                + ", clothId=" + clothId + ", productTitle=" + productTitle + ", productDescription="
                + productDescription + ", productPhoto=" + productPhoto + ", productFor=" + productFor + "]";
    }
}
