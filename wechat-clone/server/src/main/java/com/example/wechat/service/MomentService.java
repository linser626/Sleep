package com.example.wechat.service;

import com.example.wechat.entity.Moment;
import com.example.wechat.entity.MomentComment;
import com.example.wechat.entity.MomentLike;
import com.example.wechat.repository.MomentCommentRepository;
import com.example.wechat.repository.MomentLikeRepository;
import com.example.wechat.repository.MomentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MomentService {

    private final MomentRepository momentRepository;
    private final MomentLikeRepository momentLikeRepository;
    private final MomentCommentRepository momentCommentRepository;

    public MomentService(MomentRepository momentRepository,
                        MomentLikeRepository momentLikeRepository,
                        MomentCommentRepository momentCommentRepository) {
        this.momentRepository = momentRepository;
        this.momentLikeRepository = momentLikeRepository;
        this.momentCommentRepository = momentCommentRepository;
    }

    public Moment createMoment(Long userId, String content, String images) {
        Moment moment = new Moment();
        moment.setUserId(userId);
        moment.setContent(content);
        moment.setImages(images);
        return momentRepository.save(moment);
    }

    public List<Moment> getAllMoments() {
        return momentRepository.findAllByOrderByCreatedAtDesc();
    }

    public List<Moment> getUserMoments(Long userId) {
        return momentRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    @Transactional
    public void likeMoment(Long momentId, Long userId) {
        if (momentLikeRepository.existsByMomentIdAndUserId(momentId, userId)) {
            throw new IllegalArgumentException("已经点赞过");
        }

        MomentLike like = new MomentLike();
        like.setMomentId(momentId);
        like.setUserId(userId);
        momentLikeRepository.save(like);

        Moment moment = momentRepository.findById(momentId).orElseThrow();
        moment.setLikeCount(moment.getLikeCount() + 1);
        momentRepository.save(moment);
    }

    @Transactional
    public void unlikeMoment(Long momentId, Long userId) {
        MomentLike like = momentLikeRepository.findByMomentIdAndUserId(momentId, userId)
                .orElseThrow(() -> new IllegalArgumentException("没有点赞过"));

        momentLikeRepository.delete(like);

        Moment moment = momentRepository.findById(momentId).orElseThrow();
        moment.setLikeCount(Math.max(0, moment.getLikeCount() - 1));
        momentRepository.save(moment);
    }

    @Transactional
    public MomentComment commentMoment(Long momentId, Long userId, String content, Long replyToUserId) {
        MomentComment comment = new MomentComment();
        comment.setMomentId(momentId);
        comment.setUserId(userId);
        comment.setContent(content);
        comment.setReplyToUserId(replyToUserId);
        MomentComment savedComment = momentCommentRepository.save(comment);

        Moment moment = momentRepository.findById(momentId).orElseThrow();
        moment.setCommentCount(moment.getCommentCount() + 1);
        momentRepository.save(moment);

        return savedComment;
    }

    public List<MomentComment> getMomentComments(Long momentId) {
        return momentCommentRepository.findByMomentIdOrderByCreatedAtAsc(momentId);
    }

    public boolean isLiked(Long momentId, Long userId) {
        return momentLikeRepository.existsByMomentIdAndUserId(momentId, userId);
    }
}