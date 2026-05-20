package com.example.wechat.service;

import com.example.wechat.entity.Message;
import com.example.wechat.repository.MessageRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class MessageService {

    private final MessageRepository messageRepository;

    public MessageService(MessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    public Message sendPrivateMessage(Long senderId, Long receiverId, String content, String type) {
        Message message = new Message();
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setContent(content);
        message.setType(type);
        message.setSendTime(LocalDateTime.now());
        message.setIsRevoked(false);
        message.setIsRead(false);

        return messageRepository.save(message);
    }

    public Message sendGroupMessage(Long senderId, Long groupId, String content, String type) {
        Message message = new Message();
        message.setSenderId(senderId);
        message.setGroupId(groupId);
        message.setContent(content);
        message.setType(type);
        message.setSendTime(LocalDateTime.now());
        message.setIsRevoked(false);
        message.setIsRead(false);

        return messageRepository.save(message);
    }

    public List<Message> getPrivateChatHistory(Long userId, Long friendId) {
        return messageRepository.findBySenderIdAndReceiverIdOrReceiverIdAndSenderIdOrderBySendTimeDesc(
                userId, friendId, userId, friendId);
    }

    public List<Message> getGroupChatHistory(Long groupId) {
        return messageRepository.findByGroupIdOrderBySendTimeDesc(groupId);
    }

    @Transactional
    public Message revokeMessage(Long messageId, Long userId) {
        Message message = messageRepository.findById(messageId)
                .orElseThrow(() -> new IllegalArgumentException("消息不存在"));

        if (!message.getSenderId().equals(userId)) {
            throw new IllegalArgumentException("只能撤回自己的消息");
        }

        message.setIsRevoked(true);
        return messageRepository.save(message);
    }

    public List<Message> searchMessages(Long userId, String keyword) {
        return messageRepository.findAll().stream()
                .filter(m -> (m.getSenderId().equals(userId) || m.getReceiverId().equals(userId))
                        && m.getContent().contains(keyword)
                        && !m.getIsRevoked())
                .toList();
    }
}