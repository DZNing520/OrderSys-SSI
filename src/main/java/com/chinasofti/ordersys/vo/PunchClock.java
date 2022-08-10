package com.chinasofti.ordersys.vo;

import java.util.Date;

/**
 * @author BigEyeMonster
 * @create 2022-08-05-19:38
 */
public class PunchClock {
    private Integer id;//标识
    private Long userid;//用户ID
    private Date punch_inTime;//打卡时间
    private Date punch_outTime;//签退时间
    private Date attendanceTime;//考勤时间
    private String remark;//迟到原因备注
    private String userip;//ip地址
    private String loginaddress;//登录地址
    private String developername;//用户名

    public PunchClock() {
    }

    public PunchClock(Integer id, Long userid, Date punch_inTime, Date punch_outTime, Date attendanceTime, String remark, String userip, String loginaddress, String developername) {
        this.id = id;
        this.userid = userid;
        this.punch_inTime = punch_inTime;
        this.punch_outTime = punch_outTime;
        this.attendanceTime = attendanceTime;
        this.remark = remark;
        this.userip = userip;
        this.loginaddress = loginaddress;
        this.developername = developername;
    }

    @Override
    public String toString() {
        return "PunchClock{" +
                "id=" + id +
                ", userid=" + userid +
                ", punch_inTime=" + punch_inTime +
                ", punch_outTime=" + punch_outTime +
                ", attendanceTime=" + attendanceTime +
                ", remark='" + remark + '\'' +
                ", userip='" + userip + '\'' +
                ", loginaddress='" + loginaddress + '\'' +
                ", developername='" + developername + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    public Date getPunch_inTime() {
        return punch_inTime;
    }

    public void setPunch_inTime(Date punch_inTime) {
        this.punch_inTime = punch_inTime;
    }

    public Date getPunch_outTime() {
        return punch_outTime;
    }

    public void setPunch_outTime(Date punch_outTime) {
        this.punch_outTime = punch_outTime;
    }

    public Date getAttendanceTime() {
        return attendanceTime;
    }

    public void setAttendanceTime(Date attendanceTime) {
        this.attendanceTime = attendanceTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUserip() {
        return userip;
    }

    public void setUserip(String userip) {
        this.userip = userip;
    }

    public String getLoginaddress() {
        return loginaddress;
    }

    public void setLoginaddress(String loginaddress) {
        this.loginaddress = loginaddress;
    }

    public String getDevelopername() {
        return developername;
    }

    public void setDevelopername(String developername) {
        this.developername = developername;
    }
}
