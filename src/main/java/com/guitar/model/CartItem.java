package com.guitar.model;

public class CartItem {

    private String guitarName;
    private double price;
    private int discount;

    public CartItem(String guitarName, double price, int discount) {
        this.guitarName = guitarName;
        this.price = price;
        this.discount = discount;
    }

    public String getGuitarName() {
        return guitarName;
    }

    public void setGuitarName(String guitarName) {
        this.guitarName = guitarName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }
}