package com.chinasofti.ordersys.service;

import com.chinasofti.ordersys.mapper.PunchClockDao;
import com.chinasofti.ordersys.vo.PunchClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author BigEyeMonster
 * @create 2022-08-05-19:49
 */
@Service
class PunchClockServiceImpl implements PunchClockManager {
    @Autowired
    private PunchClockDao punchClockDao;

    @Override
    public int up_out(PunchClock punchClock) {
        return punchClockDao.up_out(punchClock);
    }

    @Override
    public int add_in(PunchClock punchClock) {
        return punchClockDao.add_in(punchClock);
    }

    @Override
    public PunchClock if_punchin(PunchClock punchClock) {
        return punchClockDao.if_punchin(punchClock);
    }

    @Override
    public PunchClock if_punchout(PunchClock punchClock) {
        return punchClockDao.if_punchout(punchClock);
    }

    @Override
    public int late_result(PunchClock punchClock) {
        return punchClockDao.late_result(punchClock);
    }
}
