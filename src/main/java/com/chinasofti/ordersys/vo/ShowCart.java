package com.chinasofti.ordersys.vo;

public class ShowCart {
    private String dishesImg;
    private float dishesPrice;
    private String dishesName;
    private Integer num;
    private float sumPrice;

    public String getDishesImg() {
        return dishesImg;
    }

    public void setDishesImg(String dishesImg) {
        this.dishesImg = dishesImg;
    }

    public float getDishesPrice() {
        return dishesPrice;
    }

    public void setDishesPrice(float dishesPrice) {
        this.dishesPrice = dishesPrice;
    }

    public String getDishesName() {
        return dishesName;
    }

    public void setDishesName(String dishesName) {
        this.dishesName = dishesName;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public float getSumPrice() {
        return this.dishesPrice*this.num;
    }

    public void setSumPrice(float price,int num) {
        this.sumPrice = price*num;
    }

    public ShowCart() {

    }

    public ShowCart(String dishesImg, float dishesPrice, String dishesName, Integer num, float sumPrice) {
        this.dishesImg = dishesImg;
        this.dishesPrice = dishesPrice;
        this.dishesName = dishesName;
        this.num = num;
        this.sumPrice = sumPrice;
    }

    @Override
    public String toString() {
        return "ShowCart{" +
                "dishesImg='" + dishesImg + '\'' +
                ", dishesPrice=" + dishesPrice +
                ", dishesName='" + dishesName + '\'' +
                ", num=" + num +
                ", sumPrice=" + sumPrice +
                '}';
    }
}
