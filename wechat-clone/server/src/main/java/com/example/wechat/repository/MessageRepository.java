package com.example.wechat.repository;

import com.example.wechat.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findBySenderIdAndReceiverIdOrderBySendTimeDesc(Long senderId, Long receiverId);
    List<Message> findByReceiverIdAndSenderIdOrderBySendTimeDesc(Long receiverId, Long senderId);
    List<Message> findByGroupIdOrderBySendTimeDesc(Long groupId);
    List<Message> findBySenderIdAndReceiverIdOrReceiverIdAndSenderIdOrderBySendTimeDesc(
            Long senderId1, Long receiverId1, Long senderId2, Long receiverId2);
}