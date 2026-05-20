package com.example.wechat.controller;

import com.example.wechat.common.Response;
import com.example.wechat.entity.Group;
import com.example.wechat.entity.GroupMember;
import com.example.wechat.service.GroupService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/groups")
public class GroupController {

    private final GroupService groupService;

    public GroupController(GroupService groupService) {
        this.groupService = groupService;
    }

    @GetMapping
    public Response getUserGroups() {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Group> groups = groupService.getUserGroups(userId);
        return Response.success(groups);
    }

    @GetMapping("/{groupId}/members")
    public Response getGroupMembers(@PathVariable Long groupId) {
        List<GroupMember> members = groupService.getGroupMembers(groupId);
        return Response.success(members);
    }

    @PostMapping("/create")
    public Response createGroup(@RequestBody Map<String, String> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String name = request.get("name");

        Group group = groupService.createGroup(userId, name);
        return Response.success("群聊创建成功", group);
    }

    @PostMapping("/{groupId}/members/add")
    public Response addMember(@PathVariable Long groupId, @RequestBody Map<String, Object> request) {
        Long userId = Long.parseLong(request.get("userId").toString());
        groupService.addMember(groupId, userId);
        return Response.success("成员添加成功");
    }

    @PostMapping("/{groupId}/members/remove")
    public Response removeMember(@PathVariable Long groupId, @RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long memberId = Long.parseLong(request.get("memberId").toString());

        groupService.removeMember(groupId, memberId, userId);
        return Response.success("成员已移除");
    }

    @PostMapping("/{groupId}/announcement")
    public Response updateAnnouncement(@PathVariable Long groupId, @RequestBody Map<String, String> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String announcement = request.get("announcement");

        Group group = groupService.updateAnnouncement(groupId, announcement, userId);
        return Response.success("公告更新成功", group);
    }

    @PostMapping("/{groupId}/admin")
    public Response setAdmin(@PathVariable Long groupId, @RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long memberId = Long.parseLong(request.get("memberId").toString());

        groupService.setAdmin(groupId, memberId, userId);
        return Response.success("管理员设置成功");
    }
}