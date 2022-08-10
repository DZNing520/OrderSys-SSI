package com.chinasofti.ordersys.controller.admin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.chinasofti.ordersys.service.admin.AdminPayService;
import com.chinasofti.ordersys.service.admin.CheckOutTableService;
import com.chinasofti.ordersys.vo.AdminCheckOut;
import com.chinasofti.ordersys.vo.CheckOutTable_;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * @author BigEyeMonster
 * @create 2022-07-28-16:08
 */
@Controller
public class AdminPayController {

    @Autowired
    private AdminPayService adminPayService;

    @Autowired
    private CheckOutTableService checkOutTableService;

    //支付
    @RequestMapping("/adminPay")
    public String adminPay(Model model, AdminCheckOut adminCheckOut, HttpSession session) {
        adminCheckOut.setOrderInfo("test");
        String form = adminPayService.adminPay(adminCheckOut);
        model.addAttribute("form", form);
        //将该订单的相关数据存放在session中，为打印凭条数据展示
        CheckOutTable_ orderInfo = checkOutTableService.getOrderInfo(adminCheckOut.getOrderId());
        session.setAttribute("orderInfo", orderInfo);
        //将当前该数据的状态改为1
        checkOutTableService.updateOrderStatus(adminCheckOut.getOrderId());
        return "/pages/admin/adminPay.jsp";
    }

    //支付成功跳转页面
    @RequestMapping("/adminReturn")
    public String returnNotice(Model model, String out_trade_no) {
        String query = adminPayService.query(out_trade_no);
        model.addAttribute("query", JSON.toJSONString(query, SerializerFeature.PrettyFormat));
        return "/pages/admin/showAdminPayOrder.jsp";
    }
}
