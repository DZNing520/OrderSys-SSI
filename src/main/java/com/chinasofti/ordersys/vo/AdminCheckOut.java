package com.chinasofti.ordersys.vo;

/**
 * @author BigEyeMonster
 * @create 2022-07-28-21:22
 */
public class AdminCheckOut {
    //订单号
    private String orderId;
    //总价
    private double price;
    //订单备注信息
    private String orderInfo;

    public AdminCheckOut() {
    }

    public AdminCheckOut(String orderId, Double price, String orderInfo) {
        this.orderId = orderId;
        this.price = price;
        this.orderInfo = orderInfo;
    }

    @Override
    public String toString() {
        return "AdminCheckOut{" +
                "orderId='" + orderId + '\'' +
                ", price=" + price +
                ", orderInfo='" + orderInfo + '\'' +
                '}';
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getOrderInfo() {
        return orderInfo;
    }

    public void setOrderInfo(String orderInfo) {
        this.orderInfo = orderInfo;
    }
}
