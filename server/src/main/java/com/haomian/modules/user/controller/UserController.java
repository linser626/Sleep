package com.haomian.modules.user.controller;

import com.haomian.common.Result;
import com.haomian.modules.user.entity.User;
import com.haomian.modules.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/{id}")
    public Result<User> getUserById(@PathVariable Long id) {
        User user = userService.getById(id);
        if (user == null) {
            return Result.error("用户不存在");
        }
        return Result.success("查询成功", user);
    }

    @PutMapping("/{id}")
    public Result<User> updateUser(@PathVariable Long id, @RequestBody Map<String, Object> updateData) {
        User user = userService.getById(id);
        if (user == null) {
            return Result.error("用户不存在");
        }

        if (updateData.containsKey("nickname")) {
            user.setNickname((String) updateData.get("nickname"));
        }
        if (updateData.containsKey("avatar")) {
            user.setAvatar((String) updateData.get("avatar"));
        }
        if (updateData.containsKey("sleepGoal")) {
            user.setSleepGoal((Integer) updateData.get("sleepGoal"));
        }

        user.setUpdateTime(LocalDateTime.now());
        userService.updateById(user);

        return Result.success("更新成功", user);
    }
}