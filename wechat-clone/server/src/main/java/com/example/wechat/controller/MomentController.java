package com.example.wechat.controller;

import com.example.wechat.common.Response;
import com.example.wechat.entity.Moment;
import com.example.wechat.entity.MomentComment;
import com.example.wechat.service.MomentService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/moments")
public class MomentController {

    private final MomentService momentService;

    public MomentController(MomentService momentService) {
        this.momentService = momentService;
    }

    @GetMapping
    public Response getAllMoments() {
        List<Moment> moments = momentService.getAllMoments();
        return Response.success(moments);
    }

    @GetMapping("/user/{userId}")
    public Response getUserMoments(@PathVariable Long userId) {
        List<Moment> moments = momentService.getUserMoments(userId);
        return Response.success(moments);
    }

    @GetMapping("/{momentId}/comments")
    public Response getMomentComments(@PathVariable Long momentId) {
        List<MomentComment> comments = momentService.getMomentComments(momentId);
        return Response.success(comments);
    }

    @GetMapping("/{momentId}/liked")
    public Response isLiked(@PathVariable Long momentId) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        boolean isLiked = momentService.isLiked(momentId, userId);
        return Response.success(Map.of("isLiked", isLiked));
    }

    @PostMapping
    public Response createMoment(@RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String content = (String) request.get("content");
        String images = request.get("images") != null ? (String) request.get("images") : null;

        Moment moment = momentService.createMoment(userId, content, images);
        return Response.success("发布成功", moment);
    }

    @PostMapping("/{momentId}/like")
    public Response likeMoment(@PathVariable Long momentId) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        momentService.likeMoment(momentId, userId);
        return Response.success("点赞成功");
    }

    @PostMapping("/{momentId}/unlike")
    public Response unlikeMoment(@PathVariable Long momentId) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        momentService.unlikeMoment(momentId, userId);
        return Response.success("取消点赞");
    }

    @PostMapping("/{momentId}/comment")
    public Response commentMoment(@PathVariable Long momentId, @RequestBody Map<String, Object> request) {
        Long userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String content = (String) request.get("content");
        Long replyToUserId = request.get("replyToUserId") != null 
                ? Long.parseLong(request.get("replyToUserId").toString()) 
                : null;

        MomentComment comment = momentService.commentMoment(momentId, userId, content, replyToUserId);
        return Response.success("评论成功", comment);
    }
}