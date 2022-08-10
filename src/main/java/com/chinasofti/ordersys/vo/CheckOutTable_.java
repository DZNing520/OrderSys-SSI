package com.chinasofti.ordersys.vo;

import com.github.pagehelper.PageInfo;

import java.sql.Date;
import java.util.List;

/**
 * @author BigEyeMonster
 * @create 2022-07-24-13:53
 */
public class CheckOutTable_ {
    private int orderId;
    //带结账的桌号
    private int tableId;
    //开餐时间
    private Date orderBeginDate;
    //结账时间
    private Date orderEndDate;
    //总价
    private Double sumMoney;
    //根据点餐服务员waiterId获得点餐员姓名
    private String waiterName;
    //获取未结账菜品信息
    private List<Dishes_> dishesList;

    public CheckOutTable_() {
    }

    public CheckOutTable_(int orderId, int tableId, Date orderBeginDate, Date orderEndDate, Double sumMoney, String waiterName, List<Dishes_> dishesList) {
        this.orderId = orderId;
        this.tableId = tableId;
        this.orderBeginDate = orderBeginDate;
        this.orderEndDate = orderEndDate;
        this.sumMoney = sumMoney;
        this.waiterName = waiterName;
        this.dishesList = dishesList;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    @Override
    public String toString() {
        return "CheckOutTable_{" +
                "orderId=" + orderId +
                ", tableId=" + tableId +
                ", orderBeginDate=" + orderBeginDate +
                ", orderEndDate=" + orderEndDate +
                ", sumMoney=" + sumMoney +
                ", waiterName='" + waiterName + '\'' +
                ", dishesList=" + dishesList +
                '}';
    }

    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }

    public Date getOrderBeginDate() {
        return orderBeginDate;
    }

    public void setOrderBeginDate(Date orderBeginDate) {
        this.orderBeginDate = orderBeginDate;
    }

    public Date getOrderEndDate() {
        return orderEndDate;
    }

    public void setOrderEndDate(Date orderEndDate) {
        this.orderEndDate = orderEndDate;
    }

    public Double getSumMoney() {
        return sumMoney;
    }

    public void setSumMoney(Double sumMoney) {
        this.sumMoney = sumMoney;
    }

    public String getWaiterName() {
        return waiterName;
    }

    public void setWaiterName(String waiterName) {
        this.waiterName = waiterName;
    }

    public List<Dishes_> getDishesList() {
        return dishesList;
    }

    public void setDishesList(List<Dishes_> dishesList) {
        this.dishesList = dishesList;
    }
}
