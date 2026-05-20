package com.example.wechat.service;

import com.example.wechat.entity.Contact;
import com.example.wechat.entity.User;
import com.example.wechat.repository.ContactRepository;
import com.example.wechat.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class ContactService {

    private final ContactRepository contactRepository;
    private final UserRepository userRepository;

    public ContactService(ContactRepository contactRepository, UserRepository userRepository) {
        this.contactRepository = contactRepository;
        this.userRepository = userRepository;
    }

    public Contact addContact(Long userId, Long friendId) {
        if (userId.equals(friendId)) {
            throw new IllegalArgumentException("不能添加自己为好友");
        }

        if (contactRepository.existsByUserIdAndFriendId(userId, friendId)) {
            throw new IllegalArgumentException("已经是好友");
        }

        userRepository.findById(friendId)
                .orElseThrow(() -> new IllegalArgumentException("好友不存在"));

        Contact contact = new Contact();
        contact.setUserId(userId);
        contact.setFriendId(friendId);

        Contact reverseContact = new Contact();
        reverseContact.setUserId(friendId);
        reverseContact.setFriendId(userId);

        contactRepository.save(reverseContact);
        return contactRepository.save(contact);
    }

    public List<User> getContacts(Long userId) {
        List<Contact> contacts = contactRepository.findByUserIdAndIsBlockedFalse(userId);
        List<Long> friendIds = contacts.stream()
                .map(Contact::getFriendId)
                .collect(Collectors.toList());

        return userRepository.findAllById(friendIds);
    }

    @Transactional
    public Contact blockContact(Long userId, Long friendId) {
        Contact contact = contactRepository.findByUserIdAndFriendId(userId, friendId)
                .orElseThrow(() -> new IllegalArgumentException("不是好友"));
        contact.setIsBlocked(true);
        return contactRepository.save(contact);
    }

    @Transactional
    public Contact unblockContact(Long userId, Long friendId) {
        Contact contact = contactRepository.findByUserIdAndFriendId(userId, friendId)
                .orElseThrow(() -> new IllegalArgumentException("不是好友"));
        contact.setIsBlocked(false);
        return contactRepository.save(contact);
    }

    @Transactional
    public Contact setMute(Long userId, Long friendId, boolean isMuted) {
        Contact contact = contactRepository.findByUserIdAndFriendId(userId, friendId)
                .orElseThrow(() -> new IllegalArgumentException("不是好友"));
        contact.setIsMuted(isMuted);
        return contactRepository.save(contact);
    }

    @Transactional
    public Contact updateRemark(Long userId, Long friendId, String remark) {
        Contact contact = contactRepository.findByUserIdAndFriendId(userId, friendId)
                .orElseThrow(() -> new IllegalArgumentException("不是好友"));
        contact.setRemark(remark);
        return contactRepository.save(contact);
    }

    public User searchUserByPhone(String phone) {
        return userRepository.findByPhone(phone)
                .orElseThrow(() -> new IllegalArgumentException("用户不存在"));
    }
}