package com.chinasofti.ordersys.mapper;

import com.chinasofti.ordersys.vo.Dishes_;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author BigEyeMonster
 * @create 2022-07-27-16:17
 */
@Repository
public interface EchartsMapper {

    @Select("select dishesName, dishesPrice, sum(num) dishesCount from dishesinfo, orderdishes where dishes = dishesId group by dishesName order by dishesCount desc;")
    List<Dishes_> getAllDishes();
}
