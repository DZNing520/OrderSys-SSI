package com.chinasofti.ordersys.service;

import com.chinasofti.ordersys.vo.PunchClock;
import org.springframework.stereotype.Service;

/**
 * @author BigEyeMonster
 * @create 2022-08-05-19:46
 */

public interface PunchClockManager {
    int up_out(PunchClock punchClock);

    int add_in(PunchClock punchClock);

    int late_result(PunchClock punchClock);

    PunchClock if_punchin(PunchClock punchClock);

    PunchClock if_punchout(PunchClock punchClock);
}