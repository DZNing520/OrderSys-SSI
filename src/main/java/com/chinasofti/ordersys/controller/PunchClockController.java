package com.chinasofti.ordersys.controller;

import com.chinasofti.ordersys.service.PunchClockManager;
import com.chinasofti.ordersys.vo.PunchClock;
import com.chinasofti.ordersys.vo.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.registry.infomodel.User;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author BigEyeMonster
 * @create 2022-08-05-17:17
 */
@Controller
@RequestMapping(value = "/punch_clock")
class PunchClockController {

    @Autowired
    private PunchClockManager punchClockManager;


    @RequestMapping(value = "/punchClock")
    public ModelAndView punchClock() {
        ModelAndView mv = new ModelAndView("/pages/signIn/punchClock.jsp");
        System.out.println(111);
        return mv;
    }

    @RequestMapping(value = "/lateinfo")
    public ModelAndView lateinfo() {
        ModelAndView mv = new ModelAndView("/pages/signIn/lateinfo.jsp");
        return mv;
    }

    //获取打卡时间
    @RequestMapping(value = "/in_time.do", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String in_time(HttpServletRequest request) throws Exception {
        String in_time = "";
        //获取当前操作的用户
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("USER_INFO");
        System.out.println("in_time" + userInfo);
        //user类里面只需要用户id和用户名，各位自由发挥
        PunchClock punchClock = new PunchClock();
        Date date = new Date();
        System.out.println(date);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//考勤时间格式化
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");//打卡时间格式化
        punchClock.setAttendanceTime(dateFormat.parse(dateFormat.format(date)));
        punchClock.setUserid((long) userInfo.getUserId());
        PunchClock pc = punchClockManager.if_punchin(punchClock);
        if (pc == null) {
            in_time = "当前暂未打卡!";
        } else {
            in_time = format.format(pc.getPunch_inTime());
        }
        System.out.println(in_time);
        return in_time;
    }

    //获取签退时间
    @RequestMapping(value = "/out_time.do", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String out_time(HttpServletRequest request) throws Exception {
        String out_time = "";
        //获取当前操作的用户
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("USER_INFO");
        System.out.println("out_time" + userInfo);
        PunchClock punchClock = new PunchClock();
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//考勤时间格式化
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");//打卡时间格式化
        punchClock.setAttendanceTime(dateFormat.parse(dateFormat.format(date)));
        punchClock.setUserid((long) userInfo.getUserId());
        PunchClock pc = punchClockManager.if_punchout(punchClock);
        if (pc == null) {
            out_time = "当前暂未签退！";
        } else {
            out_time = format.format(pc.getPunch_outTime());
        }
        return out_time;
    }

    //上班打卡
    @RequestMapping(value = "/punch_in.do")
    @ResponseBody
    public int punch_in(String loginaddress, HttpServletRequest request) throws Exception {
        //操作记录条数，初始化为0
        int resultTotal = 0;
        //获取用户IP地址
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip == null || ip.length() == 0 || ip.indexOf(":") > -1) {
            try {
                ip = InetAddress.getLocalHost().getHostAddress();
            } catch (UnknownHostException e) {
                ip = null;
            }
        }
        //获取当前操作的用户
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("USER_INFO");
        System.out.println("punch_in" + userInfo);
        //打卡控制
        PunchClock punchClock = new PunchClock();
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//考勤时间格式化
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");//打卡时间格式化
        Date inTime = format.parse("08:30:00");
        Date outTime = format.parse("17:30:00");
        punchClock.setPunch_inTime(format.parse(format.format(date)));
        punchClock.setUserid((long) userInfo.getUserId());
        punchClock.setDevelopername(userInfo.getUserAccount());
        Date nowTime = format.parse(format.format(date));//当前时分秒
        punchClock.setAttendanceTime(dateFormat.parse(dateFormat.format(date)));
        punchClock.setUserip(ip);
        punchClock.setLoginaddress(loginaddress);
        System.out.println(punchClock);
        //先查询用户是否已经打过卡
        if (punchClockManager.if_punchin(punchClock) == null) {
            if (nowTime.before(outTime) && nowTime.after(inTime)) {//迟到
                punchClockManager.add_in(punchClock);
                resultTotal = -2;
            } else if (nowTime.after(outTime)) {//缺席
                resultTotal = -3;
            } else if (nowTime.before(inTime)) {
                resultTotal = punchClockManager.add_in(punchClock);
            }
        } else {
            resultTotal = -4; //已经打过卡了
        }
        return resultTotal;
    }

    //迟到说明情况
    @RequestMapping(value = "/late.do")
    @ResponseBody
    public int late(String remark, HttpServletRequest request) throws Exception {
        //获取当前操作的用户
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("USER_INFO");
        System.out.println("late" + userInfo);
        int resultTotal = 0;
        PunchClock punchClock = new PunchClock();
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//考勤时间格式化
        punchClock.setAttendanceTime(dateFormat.parse(dateFormat.format(date)));
        punchClock.setUserid((long) userInfo.getUserId());
        punchClock.setRemark(remark);
        System.out.println(punchClock);
        resultTotal = punchClockManager.late_result(punchClock);
        System.out.println(resultTotal);
        return resultTotal;
    }

    //下班签退
    @RequestMapping(value = "/punch_out.do")
    @ResponseBody
    public int Punch_out(HttpServletRequest request) throws Exception {
        //获取当前操作的用户
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("USER_INFO");
        System.out.println("userInfo" + userInfo);
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//考勤时间格式化
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");//打卡时间格式化
        PunchClock punchClock = new PunchClock();
        punchClock.setPunch_outTime(format.parse(format.format(date)));
        Date nowTime = format.parse(format.format(date));//当前时分秒
        punchClock.setUserid((long) userInfo.getUserId());
        punchClock.setAttendanceTime(dateFormat.parse(dateFormat.format(date)));
        int resultTotal = 0;
        Date inTime = format.parse("11:30:00");
        //防止用户重复签退
        if (punchClockManager.if_punchout(punchClock) == null) {
            if (nowTime.before(inTime)) {//早退提示
                resultTotal = -2;
            } else if (nowTime.after(inTime)) {
                resultTotal = punchClockManager.up_out(punchClock);
            }
        } else {
            resultTotal = -3;
        }
        return resultTotal;
    }
}