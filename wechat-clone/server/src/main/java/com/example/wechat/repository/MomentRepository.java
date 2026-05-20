package com.example.wechat.repository;

import com.example.wechat.entity.Moment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MomentRepository extends JpaRepository<Moment, Long> {
    List<Moment> findByUserIdOrderByCreatedAtDesc(Long userId);
    List<Moment> findAllByOrderByCreatedAtDesc();
}