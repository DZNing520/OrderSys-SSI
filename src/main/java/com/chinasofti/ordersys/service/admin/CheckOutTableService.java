package com.chinasofti.ordersys.service.admin;

import com.aliyun.dysmsapi20170525.models.DeleteShortUrlRequest;
import com.chinasofti.ordersys.mapper.CheckOutTableMapper;
import com.chinasofti.ordersys.mapper.OrderMapper;
import com.chinasofti.ordersys.vo.CheckOutTable_;
import com.chinasofti.ordersys.vo.Dishes_;
import com.chinasofti.ordersys.vo.OrderInfo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author BigEyeMonster
 * @create 2022-07-24-14:34
 */
@Service
public class CheckOutTableService {
    @Autowired
    OrderMapper orderMapper;
    @Autowired
    CheckOutTableMapper checkOutTableMapper;

    public OrderMapper getOrderMapper() {
        return orderMapper;
    }

    public void setOrderMapper(OrderMapper orderMapper) {
        this.orderMapper = orderMapper;
    }

    public CheckOutTableMapper getCheckOutTableMapper() {
        return checkOutTableMapper;
    }

    public void setCheckOutTableMapper(CheckOutTableMapper checkOutTableMapper) {
        this.checkOutTableMapper = checkOutTableMapper;
    }

    public CheckOutTable_ getDishes(int orderId, int state, int pageNum) {
        List<CheckOutTable_> checkOutTableList = getCheckOutTableList(state, pageNum).getList();
        for (CheckOutTable_ checkOutTable_ : checkOutTableList) {
            if (checkOutTable_.getOrderId() == orderId) {
                return checkOutTable_;
            }
        }
        return null;
    }

    public PageInfo<CheckOutTable_> getCheckOutTableList(int state, int pageNum) {
        int pageSize = 5;
        PageHelper.startPage(pageNum, pageSize);
        //查询订单表获取所有提交的数据
        List<OrderInfo> orderInfoList = orderMapper.getNeedPayOrders(state);
        PageInfo<OrderInfo> pageInfo = new PageInfo<>(orderInfoList);
        List<CheckOutTable_> checkOutTableList = new ArrayList<CheckOutTable_>();
        for (OrderInfo orderInfo : orderInfoList) {
            CheckOutTable_ checkOutTable_ = new CheckOutTable_();
            checkOutTable_.setOrderBeginDate(orderInfo.getOrderBeginDate());
            checkOutTable_.setOrderEndDate(orderInfo.getOrderEndDate());
            //获取订单号
            checkOutTable_.setOrderId(orderInfo.getOrderId());
            //获取每个服务员姓名
            checkOutTable_.setWaiterName(checkOutTableMapper.getWaiterName(orderInfo.getWaiterId()));
            //获取每笔订单的总额
            checkOutTable_.setSumMoney(checkOutTableMapper.getSumMoney(state, orderInfo.getOrderId()));
            //获取所有菜信息
            checkOutTable_.setDishesList(checkOutTableMapper.getDishesList(orderInfo.getOrderId(), state));
//            PageHelper.startPage(pageNum, pageSize);
//            //获取菜品列表
//            List<Dishes_> dishesList = checkOutTableMapper.getDishesList(orderInfo.getOrderId(), state);
//            PageInfo<Dishes_> dishesPageInfo = new PageInfo<>(dishesList);
//            checkOutTable_.setPageInfo(dishesPageInfo);
            checkOutTable_.setTableId(orderInfo.getTableId());
            checkOutTableList.add(checkOutTable_);
        }
        PageInfo<CheckOutTable_> page = new PageInfo<>(checkOutTableList);
        BeanUtils.copyProperties(pageInfo, page);
        page.setList(checkOutTableList);
        return page;
    }

    public void deleteOrder(Integer orderId) {
        checkOutTableMapper.deleteOrder(orderId);
    }

    //付款之后将该订单状态置1，并将订单终止时间设置为当前时间
    public void updateOrderStatus(String orderId) {
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String endDate = f.format(new Date());
        checkOutTableMapper.updateOrderStatus(orderId, endDate);
    }

    //打印凭条
    public CheckOutTable_ getOrderInfo(String orderId) {
        OrderInfo orderInfo = orderMapper.getOrderById(Integer.parseInt(orderId));
        CheckOutTable_ checkOutTable = new CheckOutTable_();
        checkOutTable.setOrderBeginDate(orderInfo.getOrderBeginDate());
        checkOutTable.setOrderEndDate(orderInfo.getOrderEndDate());
        //获取订单号
        checkOutTable.setOrderId(orderInfo.getOrderId());
        //获取每个服务员姓名
        checkOutTable.setWaiterName(checkOutTableMapper.getWaiterName(orderInfo.getWaiterId()));
        //获取每笔订单的总额
        checkOutTable.setSumMoney(checkOutTableMapper.getSumMoney(0, orderInfo.getOrderId()));
        //获取所有菜信息
        checkOutTable.setDishesList(checkOutTableMapper.getDishesList(orderInfo.getOrderId(), 0));
        checkOutTable.setTableId(orderInfo.getTableId());
        return checkOutTable;
    }
}
