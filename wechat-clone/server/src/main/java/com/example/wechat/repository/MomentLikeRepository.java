package com.example.wechat.repository;

import com.example.wechat.entity.MomentLike;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MomentLikeRepository extends JpaRepository<MomentLike, Long> {
    Optional<MomentLike> findByMomentIdAndUserId(Long momentId, Long userId);
    boolean existsByMomentIdAndUserId(Long momentId, Long userId);
    int countByMomentId(Long momentId);
    void deleteByMomentIdAndUserId(Long momentId, Long userId);
    List<MomentLike> findByMomentId(Long momentId);
}