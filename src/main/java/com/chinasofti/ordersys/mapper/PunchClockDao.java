package com.chinasofti.ordersys.mapper;

import com.chinasofti.ordersys.vo.PunchClock;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * @author BigEyeMonster
 * @create 2022-08-05-19:50
 */
public interface PunchClockDao {
    //打卡
    @Update("update userpunchclock set punch_outTime=#{punch_outTime} where attendanceTime=#{attendanceTime} and userid=#{userid}")
    int up_out(PunchClock punchClock);

    //签退
    @Insert("insert into userpunchclock(id,userid,developername,punch_inTime,attendanceTime,userip,loginaddress) values(null,#{userid},#{developername},#{punch_inTime},#{attendanceTime},#{userip},#{loginaddress})")
    int add_in(PunchClock punchClock);

    //迟到原因备注
    @Update("update userpunchclock set remark=#{remark}   where  attendanceTime=#{attendanceTime} and userid=#{userid}")
    int late_result(PunchClock punchClock);

    //查询当前用户是否已经打卡
    @Select("select punch_inTime from userpunchclock where attendanceTime=#{attendanceTime} and userid=#{userid}")
    PunchClock if_punchin(PunchClock punchClock);

    //查询当前用户是否已经签退
    @Select("select punch_outTime from userpunchclock where attendanceTime=#{attendanceTime} and userid=#{userid}\n")
    PunchClock if_punchout(PunchClock punchClock);
}
