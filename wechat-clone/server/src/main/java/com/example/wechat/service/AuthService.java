package com.example.wechat.service;

import com.example.wechat.config.JwtUtil;
import com.example.wechat.entity.User;
import com.example.wechat.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    public AuthService(UserRepository userRepository, JwtUtil jwtUtil) {
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
        this.jwtUtil = jwtUtil;
    }

    public User register(String phone, String password, String nickname) {
        if (userRepository.existsByPhone(phone)) {
            throw new IllegalArgumentException("手机号已被注册");
        }

        User user = new User();
        user.setPhone(phone);
        user.setPassword(passwordEncoder.encode(password));
        user.setNickname(nickname);
        user.setQrCode(UUID.randomUUID().toString());

        return userRepository.save(user);
    }

    public String login(String phone, String password) {
        User user = userRepository.findByPhone(phone)
                .orElseThrow(() -> new IllegalArgumentException("手机号或密码错误"));

        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new IllegalArgumentException("手机号或密码错误");
        }

        return jwtUtil.generateToken(user.getId());
    }

    public User getUserById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("用户不存在"));
    }
}