package com.chinasofti.ordersys.service.admin;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradePagePayResponse;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.chinasofti.ordersys.vo.AdminCheckOut;
import org.springframework.stereotype.Service;

import java.io.FileReader;
import java.util.Properties;

/**
 * @author BigEyeMonster
 * @create 2022-07-28-16:24
 */
@Service
public class AdminPayService {

    private String serverUrl;
    private String appId;
    private String privateKey;
    private String alipayPublicKey;
    private String notifyUrl;
    private String returnUrl;

    public void init() {
        String path = Thread.currentThread().getContextClassLoader().getResource("adminPay.properties").getPath();
        try {
            //创建FileReader对象,添加文件流路径
            FileReader fileReader = new FileReader(path);
            //创建Properties对象
            Properties properties = new Properties();
            //加载properties
            properties.load(fileReader);
            //通过Properties对象获取文件中数据
            serverUrl = properties.getProperty("admin.url");
            appId = properties.getProperty("admin.appid");
            privateKey = properties.getProperty("admin.privateKey");
            alipayPublicKey = properties.getProperty("admin.publicKey");
            notifyUrl = properties.getProperty("admin.notifyUrl");
            returnUrl = properties.getProperty("admin.returnUrl");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //交易
    public String adminPay(AdminCheckOut adminCheckOut) {
        init();
        AlipayClient alipayClient = new DefaultAlipayClient(serverUrl, appId, privateKey, "json", "UTF-8", alipayPublicKey, "RSA2");
        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        request.setNotifyUrl(notifyUrl);
        request.setReturnUrl(returnUrl);
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", adminCheckOut.getOrderId());
        bizContent.put("total_amount", adminCheckOut.getPrice());
        bizContent.put("subject", adminCheckOut.getOrderInfo());
        bizContent.put("product_code", "FAST_INSTANT_TRADE_PAY");
        request.setBizContent(bizContent.toString());
        AlipayTradePagePayResponse response = null;
        //返回表单
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

    //查看订单信息
    public String query(String id) {
        init();
        AlipayClient alipayClient = new DefaultAlipayClient(serverUrl, appId, privateKey, "json", "UTF-8", alipayPublicKey, "RSA2");
        AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", id);
        request.setBizContent(bizContent.toString());
        AlipayTradeQueryResponse response = null;
        String result = null;
        try {
            response = alipayClient.execute(request);
            result = response.getBody();
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        return result;
    }
}
