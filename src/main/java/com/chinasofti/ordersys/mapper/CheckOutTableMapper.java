package com.chinasofti.ordersys.mapper;

import com.chinasofti.ordersys.vo.Dishes_;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;


import java.util.List;

/**
 * @author BigEyeMonster
 * @create 2022-07-24-14:35
 */
@Repository
public interface CheckOutTableMapper {

    //获取订单总额
    @Select("select sum(dishesPrice * num) sumMoney\n" +
            "from orderinfo, userinfo, dishesinfo, orderdishes\n" +
            "where orderState = #{state} and userId = waiterId and orderId = orderReference and dishes = dishesId\n" +
            "and orderId = #{orderId};")
    Double getSumMoney(@Param("state") int state, @Param("orderId") int orderId);


    //获取所有的菜品信息
    @Select("select dishesName, dishesPrice, num dishesCount\n" +
            "from orderinfo, userinfo, dishesinfo, orderdishes\n" +
            "where orderState = #{state} and userId = waiterId and orderId = orderReference and dishes = dishesId and orderId = #{orderId}")
    List<Dishes_> getDishesList(@Param("orderId") int orderId, @Param("state") int state);

    @Select("select userAccount from userinfo where userId = #{waiterId};")
    String getWaiterName(int waiterId);

    @Update("update orderinfo set orderState = 2 where orderId = #{orderId}")
    void deleteOrder(Integer orderId);

    @Update("update orderinfo set orderState = 1, orderEndDate = #{endDate} where orderId = #{orderId}")
    void updateOrderStatus(@Param("orderId") String orderId, @Param("endDate") String endDate);
}
