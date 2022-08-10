package com.chinasofti.ordersys.controller.waiters;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.chinasofti.ordersys.service.login.waiters.ShowCartService;
import com.chinasofti.ordersys.vo.Cart;
import com.chinasofti.ordersys.vo.Msg;
import com.chinasofti.ordersys.vo.ShowCart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ShowCartController {
    @Autowired
    private ShowCartService showCartService;
    /***
     *
     * @param session
     * @return
     * 返回到前端的josn数据中
     */
    @RequestMapping(value="/cart/showCart", produces = "text/html;charset=UTF-8" )
    @ResponseBody
    public String showCarts(HttpSession session){
        Cart cart = (Cart) session.getAttribute("CART");
        List<ShowCart> showCarts = showCartService.getShowCart(cart);
        return JSON.toJSONString(Msg.success().add("checkOutTable", showCarts), SerializerFeature.PrettyFormat);
    }

    @RequestMapping("/cart/clearCart")
    public void clearCart(HttpSession session){
        session.removeAttribute("CART");
    }
}
