package com.haomian.modules.user.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.haomian.modules.user.entity.User;
import com.haomian.modules.user.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserService extends ServiceImpl<UserMapper, User> {

    public User createUser(String phone) {
        User user = new User();
        user.setPhone(phone);
        user.setNickname("用户" + phone.substring(phone.length() - 4));
        user.setLevel(1);
        user.setExp(0L);
        user.setStarMoonCoins(0L);
        user.setStreakDays(0);
        user.setSleepGoal(8);
        user.setTotalSleepHours(java.math.BigDecimal.ZERO);
        user.setCreateTime(LocalDateTime.now());
        user.setUpdateTime(LocalDateTime.now());
        user.setDeleted(0);
        save(user);
        return user;
    }
}
