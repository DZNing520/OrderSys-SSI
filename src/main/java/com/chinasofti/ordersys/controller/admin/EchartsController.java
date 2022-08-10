package com.chinasofti.ordersys.controller.admin;

import com.alibaba.fastjson.JSON;
import com.chinasofti.ordersys.service.admin.EchartsService;
import com.chinasofti.ordersys.vo.Dishes_;
import com.chinasofti.ordersys.vo.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author BigEyeMonster
 * @create 2022-07-27-16:16
 */

@Controller
public class EchartsController {
    @Autowired
    private EchartsService echartsService;

    @RequestMapping("/echartsJson")
    @ResponseBody
    public String echartsJson() {
        //获取多有菜品的数据
        // 获取每个菜品的销量
        List<Dishes_> dishesList = echartsService.getDishesList();
        return JSON.toJSONString(Msg.success().add("dishesList", dishesList));
    }
}
