package com.haomian.modules.user.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.haomian.common.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("user")
public class User extends BaseEntity {
    private String phone;
    private String nickname;
    private String avatar;
    private Integer level;
    private Long exp;
    private Long starMoonCoins;
    private Integer streakDays;
    private Integer sleepGoal;
    private BigDecimal totalSleepHours;
}
