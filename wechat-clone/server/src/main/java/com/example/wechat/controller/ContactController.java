package com.example.wechat.controller;

import com.example.wechat.common.Response;
import com.example.wechat.entity.Contact;
import com.example.wechat.entity.User;
import com.example.wechat.service.ContactService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/contacts")
public class ContactController {

    private final ContactService contactService;

    public ContactController(ContactService contactService) {
        this.contactService = contactService;
    }

    @GetMapping
    public Response getContacts() {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<User> contacts = contactService.getContacts(userId);
        return Response.success(contacts);
    }

    @PostMapping("/add")
    public Response addContact(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long friendId = Long.parseLong(request.get("friendId").toString());
        
        Contact contact = contactService.addContact(userId, friendId);
        return Response.success("添加成功", contact);
    }

    @PostMapping("/search")
    public Response searchUser(@RequestBody Map<String, String> request) {
        String phone = request.get("phone");
        User user = contactService.searchUserByPhone(phone);
        
        Map<String, Object> data = Map.of(
            "userId", user.getId(),
            "nickname", user.getNickname(),
            "phone", user.getPhone(),
            "avatar", user.getAvatar()
        );
        
        return Response.success(data);
    }

    @PostMapping("/block")
    public Response blockContact(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long friendId = Long.parseLong(request.get("friendId").toString());
        
        contactService.blockContact(userId, friendId);
        return Response.success("拉黑成功");
    }

    @PostMapping("/unblock")
    public Response unblockContact(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long friendId = Long.parseLong(request.get("friendId").toString());
        
        contactService.unblockContact(userId, friendId);
        return Response.success("解除拉黑成功");
    }

    @PostMapping("/mute")
    public Response setMute(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long friendId = Long.parseLong(request.get("friendId").toString());
        boolean isMuted = (Boolean) request.get("isMuted");
        
        contactService.setMute(userId, friendId, isMuted);
        return Response.success(isMuted ? "已开启免打扰" : "已关闭免打扰");
    }

    @PostMapping("/remark")
    public Response updateRemark(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long friendId = Long.parseLong(request.get("friendId").toString());
        String remark = (String) request.get("remark");
        
        contactService.updateRemark(userId, friendId, remark);
        return Response.success("备注修改成功");
    }
}