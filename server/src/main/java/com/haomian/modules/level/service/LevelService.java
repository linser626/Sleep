package com.haomian.modules.level.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.haomian.modules.level.entity.Level;
import com.haomian.modules.level.mapper.LevelMapper;
import org.springframework.stereotype.Service;

@Service
public class LevelService extends ServiceImpl<LevelMapper, Level> {

    public Level getLevelByExp(Long exp) {
        LambdaQueryWrapper<Level> wrapper = new LambdaQueryWrapper<>();
        wrapper.le(Level::getRequiredExp, exp);
        wrapper.orderByDesc(Level::getLevel);
        wrapper.last("LIMIT 1");
        return getOne(wrapper);
    }

    public int calculateLevel(Long exp) {
        Level level = getLevelByExp(exp);
        return level != null ? level.getLevel() : 1;
    }

    public Long getNextLevelExp(Long currentExp) {
        Level currentLevel = getLevelByExp(currentExp);
        if (currentLevel == null) {
            return 100L;
        }
        
        LambdaQueryWrapper<Level> wrapper = new LambdaQueryWrapper<>();
        wrapper.gt(Level::getLevel, currentLevel.getLevel());
        wrapper.orderByAsc(Level::getLevel);
        wrapper.last("LIMIT 1");
        
        Level nextLevel = getOne(wrapper);
        return nextLevel != null ? nextLevel.getRequiredExp() - currentExp : 0L;
    }
}