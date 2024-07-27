package com.example.model;

public class Item {
    private int itemId;
    private String description;
    private String condition;
    private String photoUrl;
    private Category category;
    private int userId;
    private String status;
    private int interestedUserId;
    private String interestedUsername;

    public enum Category {
        ELECTRONICS, FURNITURE, CLOTHING
    }

    // Getters and setters for all fields
    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getInterestedUserId() {
        return interestedUserId;
    }

    public void setInterestedUserId(int interestedUserId) {
        this.interestedUserId = interestedUserId;
    }

    public String getInterestedUsername() {
        return interestedUsername;
    }

    public void setInterestedUsername(String interestedUsername) {
        this.interestedUsername = interestedUsername;
    }
}
