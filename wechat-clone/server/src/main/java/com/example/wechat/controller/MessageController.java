package com.example.wechat.controller;

import com.example.wechat.common.Response;
import com.example.wechat.entity.Message;
import com.example.wechat.service.MessageService;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/messages")
public class MessageController {

    private final MessageService messageService;

    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }

    @GetMapping("/private/{friendId}")
    public Response getPrivateChatHistory(@PathVariable Long friendId) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Message> messages = messageService.getPrivateChatHistory(userId, friendId);
        return Response.success(messages);
    }

    @GetMapping("/group/{groupId}")
    public Response getGroupChatHistory(@PathVariable Long groupId) {
        List<Message> messages = messageService.getGroupChatHistory(groupId);
        return Response.success(messages);
    }

    @PostMapping("/send/private")
    public Response sendPrivateMessage(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long receiverId = Long.parseLong(request.get("receiverId").toString());
        String content = (String) request.get("content");
        String type = request.get("type") != null ? (String) request.get("type") : "text";

        Message message = messageService.sendPrivateMessage(userId, receiverId, content, type);
        return Response.success("消息发送成功", message);
    }

    @PostMapping("/send/group")
    public Response sendGroupMessage(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long groupId = Long.parseLong(request.get("groupId").toString());
        String content = (String) request.get("content");
        String type = request.get("type") != null ? (String) request.get("type") : "text";

        Message message = messageService.sendGroupMessage(userId, groupId, content, type);
        return Response.success("消息发送成功", message);
    }

    @PostMapping("/revoke")
    public Response revokeMessage(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long messageId = Long.parseLong(request.get("messageId").toString());

        messageService.revokeMessage(messageId, userId);
        return Response.success("消息已撤回");
    }

    @PostMapping("/search")
    public Response searchMessages(@RequestBody Map<String, String> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String keyword = request.get("keyword");

        List<Message> messages = messageService.searchMessages(userId, keyword);
        return Response.success(messages);
    }

    @MessageMapping("/chat")
    @SendTo("/topic/chat")
    public Message handleMessage(Message message) {
        return message;
    }
}