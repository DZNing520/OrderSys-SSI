package com.chinasofti.ordersys.vo;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //状态码
    private int code;
    //提示信息
    private String msg;
    //用户返回给浏览器的数据
    private Map<String, Object> result = new HashMap<String, Object>();

    @Override
    public String toString() {
        return "Msg{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", result=" + result +
                '}';
    }

    public static Msg success() {
        Msg successResult = new Msg();
        successResult.setCode(100);
        successResult.setMsg("操作成功");
        return successResult;
    }

    public static Msg fail() {
        Msg failResult = new Msg();
        failResult.setCode(200);
        failResult.setMsg("操作失败");
        return failResult;
    }

    public Msg add(String key, Object value) {
        this.result.put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getResult() {
        return result;
    }

    public void setResult(Map<String, Object> result) {
        this.result = result;
    }
}
