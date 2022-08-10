package com.chinasofti.ordersys.vo;

import java.io.Serializable;

/**
 * @author BigEyeMonster
 * @create 2022-07-24-14:27
 */
public class Dishes_ implements Serializable {
    //菜品名
    private String dishesName;
    //单价
    private Double dishesPrice;
    //数量
    private Integer dishesCount;

    public Dishes_() {
    }

    public Dishes_(String dishesName, Double dishesPrice, Integer dishesCount) {
        this.dishesName = dishesName;
        this.dishesPrice = dishesPrice;
        this.dishesCount = dishesCount;
    }

    @Override
    public String toString() {
        return "Dishes_{" +
                "dishesName='" + dishesName + '\'' +
                ", dishesPrice=" + dishesPrice +
                ", dishesCount=" + dishesCount +
                '}';
    }

    public String getDishesName() {
        return dishesName;
    }

    public void setDishesName(String dishesName) {
        this.dishesName = dishesName;
    }

    public Double getDishesPrice() {
        return dishesPrice;
    }

    public void setDishesPrice(Double dishesPrice) {
        this.dishesPrice = dishesPrice;
    }

    public Integer getDishesCount() {
        return dishesCount;
    }

    public void setDishesCount(Integer dishesCount) {
        this.dishesCount = dishesCount;
    }
}
