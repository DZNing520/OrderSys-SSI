package com.chinasofti.ordersys.controller.waiters;


import com.chinasofti.ordersys.service.login.waiters.PayOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayOrderController {
    @Autowired
    private PayOrderService payOrderService;
    @RequestMapping("/payOrder")
    public String  payOrder(String orderId, Model model){
       // System.out.println(orderId);
        String form = payOrderService.pay(orderId);
        model.addAttribute("form",form);
        return "/pages/waiters/pay.jsp";
    }
    @RequestMapping("/pay/return")
    public String payReturn(){
        return "/pages/waiters/paylist.jsp";
    }
}
