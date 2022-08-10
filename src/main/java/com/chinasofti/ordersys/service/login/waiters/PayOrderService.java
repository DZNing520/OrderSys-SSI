package com.chinasofti.ordersys.service.login.waiters;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradePagePayResponse;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.chinasofti.ordersys.mapper.ShowCartMapper;
import com.chinasofti.ordersys.vo.PayOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PayOrderService {
    @Autowired
    private PayOrder payOrder;
    @Autowired
    private ShowCartMapper showCartMapper;

    public String pay(String id) {
        AlipayClient alipayClient = new DefaultAlipayClient(payOrder.getUrl(), payOrder.getAppid(), payOrder.getPrivateKey(), "json", "UTf-8", payOrder.getPublicKey(), "RSA2");
        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        request.setNotifyUrl(payOrder.getNotifyUrl());
        request.setReturnUrl(payOrder.getReturnUrl());
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", id);
        bizContent.put("total_amount", showCartMapper.getSumMoney(Integer.parseInt(id)));
        bizContent.put("subject", id + "title");
        bizContent.put("product_code", "FAST_INSTANT_TRADE_PAY");

        request.setBizContent(bizContent.toString());
        AlipayTradePagePayResponse response = null;
        String form = null;
        try {
            response = alipayClient.pageExecute(request);
            form = response.getBody();
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        return form;
    }

    public String query(String id) {
        AlipayClient alipayClient = new DefaultAlipayClient(payOrder.getUrl(), payOrder.getAppid(), payOrder.getPrivateKey(), "json", "UTf-8", payOrder.getPublicKey(), "RSA2");
        AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", id);
        request.setBizContent(bizContent.toString());
        AlipayTradeQueryResponse response = null;
        String body = null;
        try {
            response = alipayClient.execute(request);
            body = response.getBody();
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        return body;
    }
}
