package com.haomian.modules.level.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.haomian.common.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("level")
public class Level extends BaseEntity {
    private Integer level;
    @TableField("title")
    private String name;
    @TableField("min_exp")
    private Long requiredExp;
    private String icon;
    @TableField("reward_desc")
    private String description;
}