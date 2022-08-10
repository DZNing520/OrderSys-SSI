package com.chinasofti.ordersys.service.login;


import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.profile.DefaultProfile;
import com.chinasofti.ordersys.mapper.UserInfoMapper;
import com.chinasofti.ordersys.vo.UserInfo;
import com.chinasofti.util.sec.Passport;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class RegService {
    @Autowired
    private UserInfoMapper userInfoMapper;

//    public static void main(String[] args) {
//        int appId = 1400720635;
//        String key = "70a52bae7fa8cf4b75f7e740096e746d";
//        int templeId = 1504427;
//        String smsSign = "小宁学Java";
//        Sms sms = new Sms();
//        String code = sms.getCode();
//        System.out.println(code);
//
//        try {
//            String[] params = {code};
//            SmsSingleSender smsSingleSender = new SmsSingleSender(appId,key);
//            SmsSingleSenderResult result = smsSingleSender.sendWithParam("86","13327823481",templeId,params,smsSign,"","");
//            System.out.println(result);
//        } catch (HTTPException e){
//            System.out.println("1");
//            e.printStackTrace();
//        } catch (JSONException e){
//            System.out.println("2");
//            e.printStackTrace();
//        } catch (IOException e){
//            System.out.println("3");
//            e.printStackTrace();
//        } catch (com.github.qcloudsms.httpclient.HTTPException e) {
//            throw new RuntimeException(e);
//        }
//    }
    public void addUserInfo(String userAccount, String userPass, int role) {
        Passport passport = new Passport();
        UserInfo userInfo = new UserInfo(userAccount, passport.md5(userPass), role);
        System.out.println(userInfo);
        userInfoMapper.addUser(userInfo);
    }

    public String sendCode(String tel) {
        int code = (int)(Math.round((Math.random()+1) * 1000));
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou",
                "LTAI5tB32u2DbvMFT4k5UceH",
                "H6eqHGko99Tc8WpbpHMDZRoVgVCY3x");

        IAcsClient client = new DefaultAcsClient(profile);

        SendSmsRequest request = new SendSmsRequest();
        request.setSignName("阿里云短信测试");
        request.setTemplateCode("SMS_154950909");
        request.setPhoneNumbers(tel);
        request.setTemplateParam("{\"code\":\""+code+"\"}");

        try {
            SendSmsResponse response = client.getAcsResponse(request);
            System.out.println(new Gson().toJson(response));
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            System.out.println("ErrCode:" + e.getErrCode());
            System.out.println("ErrMsg:" + e.getErrMsg());
            System.out.println("RequestId:" + e.getRequestId());
        }
        return Integer.toString(code);
    }

   /* public String sendCode(String phoneNumber){
        int appId = 1400720635;
        String key = "70a52bae7fa8cf4b75f7e740096e746d";
        int templeId = 1504427;
        String smsSign = "小宁学Java";
        Sms sms = new Sms();
        String code = sms.getCode();
        try {
            String[] params = {code};
            SmsSingleSender smsSingleSender = new SmsSingleSender(appId,key);
            SmsSingleSenderResult result = smsSingleSender.sendWithParam("86",phoneNumber,templeId,params,smsSign,"","");
            System.out.println(result);
        } catch (HTTPException e){
            System.out.println("1");
            e.printStackTrace();
        } catch (JSONException e){
            System.out.println("2");
            e.printStackTrace();
        } catch (IOException e){
            System.out.println("3");
            e.printStackTrace();
        } catch (com.github.qcloudsms.httpclient.HTTPException e) {
            throw new RuntimeException(e);
        }
        return code;
    }*/
}
