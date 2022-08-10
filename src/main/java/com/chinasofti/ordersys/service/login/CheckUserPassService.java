/**
 * Copyright 2015 ChinaSoft International Ltd. All rights reserved.
 */
package com.chinasofti.ordersys.service.login;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinasofti.ordersys.mapper.UserInfoMapper;
import com.chinasofti.ordersys.vo.UserInfo;
import com.chinasofti.util.sec.Passport;

/**
 * <p>
 * Title: CheckUserPassService
 * </p>
 * <p>
 * Description: 判定用户密码是否正确的服务对象
 * </p>
 * <p>
 * Copyright: Copyright (c) 2015
 * </p>
 * <p>
 * Company: ChinaSoft International Ltd.
 * </p>
 *
 * @author etc
 * @version 1.0
 */
@Service
public class CheckUserPassService {
    @Autowired
    UserInfoMapper mapper;


    public UserInfoMapper getMapper() {
        return mapper;
    }


    public void setMapper(UserInfoMapper mapper) {
        this.mapper = mapper;
    }


    /**
     * 验证用户用户名密码是否正确的方法
     *
     * @param info
     *            用于判定用户名、密码的用户对象
     * @return 用户名、密码是否验证通过，true表示用户名密码正确、false表示用户名或密码错误
     * */
    public boolean checkPass(UserInfo info) {

        // 根据给定的用户名查询用户信息
        List<UserInfo> userList = mapper.checkPass(info);
        // 判定查询结果集合
        switch (userList.size()) {
            // 如果没有查询到任何数据
            case 0:
                // 返回验证失败
                return false;
            // 如果查询到一条记录则判定密码是否一致
            case 1:
                // 构建加密对象
                Passport passport = new Passport();
                // 判定用户给定的密码和数据库中的密码是否一致
                if (userList.get(0).getUserPass()
                        .equals(passport.md5(info.getUserPass()))) {
                    // 如果一致，则返回true
                    return true;
                    // 如果不一致
                } else {
                    // 返回用户名、密码不匹配
                    return false;
                }

        }
        // 其他情况下返回验证失败
        return false;
    }
}
