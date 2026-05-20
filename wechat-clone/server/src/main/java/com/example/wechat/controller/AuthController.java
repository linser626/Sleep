package com.example.wechat.controller;

import com.example.wechat.common.Response;
import com.example.wechat.entity.User;
import com.example.wechat.service.AuthService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register")
    public Response register(@RequestBody Map<String, String> request) {
        String phone = request.get("phone");
        String password = request.get("password");
        String nickname = request.get("nickname");

        User user = authService.register(phone, password, nickname);
        
        Map<String, Object> data = new HashMap<>();
        data.put("userId", user.getId());
        data.put("nickname", user.getNickname());
        data.put("phone", user.getPhone());
        
        return Response.success("注册成功", data);
    }

    @PostMapping("/login")
    public Response login(@RequestBody Map<String, String> request) {
        String phone = request.get("phone");
        String password = request.get("password");

        String token = authService.login(phone, password);
        
        Map<String, Object> data = new HashMap<>();
        data.put("token", token);
        
        return Response.success("登录成功", data);
    }

    @GetMapping("/me")
    public Response getCurrentUser() {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = authService.getUserById(userId);
        
        Map<String, Object> data = new HashMap<>();
        data.put("userId", user.getId());
        data.put("nickname", user.getNickname());
        data.put("phone", user.getPhone());
        data.put("avatar", user.getAvatar());
        data.put("signature", user.getSignature());
        
        return Response.success(data);
    }
}