package com.chinasofti.ordersys.service.admin;

import com.chinasofti.ordersys.mapper.EchartsMapper;
import com.chinasofti.ordersys.vo.Dishes_;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author BigEyeMonster
 * @create 2022-07-27-16:16
 */
@Service
public class EchartsService {

    @Autowired
    private EchartsMapper mapper;

    public List<Dishes_> getDishesList() {
        return mapper.getAllDishes();
    }
}
