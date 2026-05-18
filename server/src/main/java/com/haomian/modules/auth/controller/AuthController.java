package com.haomian.modules.auth.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.haomian.common.Result;
import com.haomian.modules.auth.dto.LoginRequest;
import com.haomian.modules.auth.util.JwtUtil;
import com.haomian.modules.user.entity.User;
import com.haomian.modules.user.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@Valid @RequestBody LoginRequest request) {
        // 简单模拟验证码验证，实际应集成短信服务
        if (!"123456".equals(request.getCode())) {
            return Result.error("验证码错误");
        }

        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getPhone, request.getPhone());
        User user = userService.getOne(wrapper);

        if (user == null) {
            user = userService.createUser(request.getPhone());
        }

        String token = jwtUtil.generateToken(user.getId(), user.getPhone());

        Map<String, Object> data = new HashMap<>();
        data.put("token", token);
        data.put("user", user);

        return Result.success("登录成功", data);
    }

    @PostMapping("/send-code")
    public Result<Void> sendCode(@RequestParam String phone) {
        // 简单模拟发送验证码，实际应集成短信服务
        System.out.println("发送验证码到 " + phone + ": 123456");
        return Result.success("验证码已发送", null);
    }
}
