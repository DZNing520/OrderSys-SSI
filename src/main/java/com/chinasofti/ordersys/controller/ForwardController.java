package com.chinasofti.ordersys.controller;

import com.chinasofti.ordersys.controller.admin.CheckOutTableController;
import com.chinasofti.ordersys.vo.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class ForwardController {

    @Autowired
    CheckOutTableController checkOutTableController;

    @RequestMapping("/toadddishes")
    public String toAddDishes() {
        return "/pages/admin/adddishes.jsp";
    }

    @RequestMapping("/toadd")
    public String toAddUserServlet() {
        return "/pages/admin/adduser.jsp";
    }

    @RequestMapping("/toadminmain")
    public String toAdminMain(Model model, @RequestParam(defaultValue = "1", required = false) int pageNum) {
        //查询所有未结账订单
        Msg msg = checkOutTableController.getCheckOutTableList(0, pageNum);
        model.addAttribute("msg", msg);
        return "/pages/admin/main.jsp";
    }

    @RequestMapping("/todishesadmin")
    public String toDishesAdmin() {
        return "/pages/admin/dishesadmin.jsp";
    }

    @RequestMapping("/tokitchenmain")
    public String toKitchenMain() {
        return "/pages/kitchen/kitchenmain.jsp";
    }

    @RequestMapping("/toonlinekitchen")
    public String toOnlineKitchen() {
        return "/pages/admin/onlinekitchens.jsp";
    }

    @RequestMapping("/toonlinewaiters")
    public String toOnlineWaiters() {
        return "/pages/admin/onlinewaiters.jsp";
    }

    @RequestMapping("/tooperatedata")
    public String toOperateData(Model model, @RequestParam(defaultValue = "1", required = false) int pageNum) {
        Msg msg = checkOutTableController.getCheckOutTableList(1, pageNum);
        model.addAttribute("msg", msg);
        return "/pages/admin/operatedata.jsp";
    }

    @RequestMapping("/topaylist")
    public String toPayList() {
        return "/pages/waiters/paylist.jsp";
    }

    @RequestMapping("/towaitermain")
    public String toWaiterMain() {
        return "/pages/waiters/takeorder.jsp";
    }

    @RequestMapping("/modifymyinfo")
    public String toModifyMyInfo() {
        return "/pages/users/modifyuser.jsp";
    }

    @RequestMapping("/touseradmin")
    public String toUserAdmin() {
        return "/pages/admin/useradmin.jsp";
    }

    @RequestMapping("/")
    public String toRoot() {
        return "/pages/login.jsp";
    }

}
