package com.example.wechat.service;

import com.example.wechat.entity.Group;
import com.example.wechat.entity.GroupMember;
import com.example.wechat.repository.GroupMemberRepository;
import com.example.wechat.repository.GroupRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class GroupService {

    private final GroupRepository groupRepository;
    private final GroupMemberRepository groupMemberRepository;

    public GroupService(GroupRepository groupRepository, GroupMemberRepository groupMemberRepository) {
        this.groupRepository = groupRepository;
        this.groupMemberRepository = groupMemberRepository;
    }

    @Transactional
    public Group createGroup(Long ownerId, String name) {
        Group group = new Group();
        group.setName(name);
        group.setOwnerId(ownerId);
        Group savedGroup = groupRepository.save(group);

        GroupMember ownerMember = new GroupMember();
        ownerMember.setGroupId(savedGroup.getId());
        ownerMember.setUserId(ownerId);
        ownerMember.setIsAdmin(true);
        groupMemberRepository.save(ownerMember);

        return savedGroup;
    }

    @Transactional
    public void addMember(Long groupId, Long userId) {
        if (groupMemberRepository.existsByGroupIdAndUserId(groupId, userId)) {
            throw new IllegalArgumentException("用户已经在群里");
        }

        GroupMember member = new GroupMember();
        member.setGroupId(groupId);
        member.setUserId(userId);
        member.setIsAdmin(false);
        groupMemberRepository.save(member);
    }

    @Transactional
    public void removeMember(Long groupId, Long userId, Long currentUserId) {
        Group group = groupRepository.findById(groupId)
                .orElseThrow(() -> new IllegalArgumentException("群不存在"));

        if (!group.getOwnerId().equals(currentUserId)) {
            throw new IllegalArgumentException("只有群主可以移除成员");
        }

        groupMemberRepository.deleteByGroupIdAndUserId(groupId, userId);
    }

    @Transactional
    public Group updateAnnouncement(Long groupId, String announcement, Long userId) {
        Group group = groupRepository.findById(groupId)
                .orElseThrow(() -> new IllegalArgumentException("群不存在"));

        GroupMember member = groupMemberRepository.findByGroupIdAndUserId(groupId, userId)
                .orElseThrow(() -> new IllegalArgumentException("你不是群成员"));

        if (!member.getIsAdmin() && !group.getOwnerId().equals(userId)) {
            throw new IllegalArgumentException("只有管理员可以修改公告");
        }

        group.setAnnouncement(announcement);
        return groupRepository.save(group);
    }

    @Transactional
    public void setAdmin(Long groupId, Long userId, Long currentUserId) {
        Group group = groupRepository.findById(groupId)
                .orElseThrow(() -> new IllegalArgumentException("群不存在"));

        if (!group.getOwnerId().equals(currentUserId)) {
            throw new IllegalArgumentException("只有群主可以设置管理员");
        }

        GroupMember member = groupMemberRepository.findByGroupIdAndUserId(groupId, userId)
                .orElseThrow(() -> new IllegalArgumentException("用户不在群里"));

        member.setIsAdmin(true);
        groupMemberRepository.save(member);
    }

    public List<Group> getUserGroups(Long userId) {
        List<Long> groupIds = groupMemberRepository.findByUserId(userId)
                .stream()
                .map(GroupMember::getGroupId)
                .toList();
        return groupRepository.findAllById(groupIds);
    }

    public List<GroupMember> getGroupMembers(Long groupId) {
        return groupMemberRepository.findByGroupId(groupId);
    }
}