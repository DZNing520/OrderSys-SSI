package com.chinasofti.ordersys.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.chinasofti.ordersys.service.login.RegService;
import com.chinasofti.ordersys.vo.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RegisterController {

    @Autowired
    private RegService regService;

    @RequestMapping(value="/register", method = RequestMethod.POST)
    public String addUser(String userAccount, String userPass, int role, HttpServletRequest request) {
        String url = request.getContextPath();
        regService.addUserInfo(userAccount, userPass, role);
        return url;
    }
    @RequestMapping(value = "/regCode")
    @ResponseBody
    public String sendCode(String tel){
        String code = regService.sendCode(tel);
        System.out.println(code);
        return JSON.toJSONString(Msg.success().add("code", code), SerializerFeature.PrettyFormat);
    }
}
