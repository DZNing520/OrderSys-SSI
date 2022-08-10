package com.chinasofti.ordersys.controller.admin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.chinasofti.ordersys.service.admin.CheckOutTableService;
import com.chinasofti.ordersys.vo.CheckOutTable_;
import com.chinasofti.ordersys.vo.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.util.List;


/**
 * @author BigEyeMonster
 * @create 2022-07-24-14:33
 */
@Controller
public class CheckOutTableController {
    //获取未提交数据
    @Autowired
    private CheckOutTableService checkOutTableService;

    public Msg getCheckOutTableList(int state, int pageNum) {
        PageInfo<CheckOutTable_> checkOutTableList = checkOutTableService.getCheckOutTableList(state, pageNum);
        return Msg.success().add("checkOutTableList", checkOutTableList);
    }

    @RequestMapping(value = "/getDishesList", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getDishesList(@Param("orderId") Integer orderId, Integer state, @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum) {
        CheckOutTable_ checkOutTable = checkOutTableService.getDishes(orderId, state, pageNum);
        return JSON.toJSONString(Msg.success().add("checkOutTable", checkOutTable), SerializerFeature.PrettyFormat);
    }

    @RequestMapping("/deleteOrder")
    @ResponseBody
    public String deleteOrder(Integer orderId) {
        //只能假删除，将相关表中的数据状态置2
        checkOutTableService.deleteOrder(orderId);
        return "success";
    }
}
