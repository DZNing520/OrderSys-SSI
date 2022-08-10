package com.chinasofti.ordersys.mapper;

import com.chinasofti.ordersys.vo.DishesInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ShowCartMapper {

    @Select("select * from dishesinfo where dishesId=#{dishesId}")
    DishesInfo getShowCartByInfo(@Param("dishesId")Integer dishesId);

    @Select("select sum(dishesinfo, orderdishes\n" +
            "where userId = waiterId and orderId = orderReference and dishes = dishesId\n" +
            "and orderId = #{orderId};")
    Double getSumMoney( @Param("orderId") int orderId);
}
