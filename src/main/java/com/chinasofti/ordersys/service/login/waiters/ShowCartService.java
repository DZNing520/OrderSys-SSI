package com.chinasofti.ordersys.service.login.waiters;

import com.chinasofti.ordersys.mapper.ShowCartMapper;
import com.chinasofti.ordersys.vo.Cart;
import com.chinasofti.ordersys.vo.DishesInfo;
import com.chinasofti.ordersys.vo.ShowCart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ShowCartService {

    @Autowired
    private ShowCartMapper showCartMapper;

    public List<ShowCart> getShowCart(Cart cart) {
        List<ShowCart> showCarts = new ArrayList<>();
//        int tableNumber = cart.getUnits().size();
        ArrayList<Cart.CartUnit> units = cart.getUnits();
        //处理相同的数据
        for (int i = 0; i < units.size(); i++) {
            int disid = units.get(i).getDishesId();
            int disnum = units.get(i).getNum();
            for (int j = i + 1; j < units.size(); j++) {
                if (units.get(j).getDishesId() == disid) {
                    units.get(i).setNum(units.get(j).getNum() + disnum);
                    units.remove(j);
                }
            }
        }

        //返回对象数据
        for (Cart.CartUnit unit : units) {
            ShowCart showCart = new ShowCart();
            DishesInfo dishesInfo = showCartMapper.getShowCartByInfo(unit.getDishesId());
            showCart.setDishesImg(dishesInfo.getDishesImg());
            showCart.setDishesName(dishesInfo.getDishesName());
            showCart.setDishesPrice(dishesInfo.getDishesPrice());
            showCart.setNum(unit.getNum());
            showCart.setSumPrice(dishesInfo.getDishesPrice(), unit.getNum());
            showCarts.add(showCart);
        }
        return showCarts;
    }

}