package com.example.demo.entity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.time.LocalDateTime;

@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class BaseEntity implements Serializable {
    
    @Getter
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    protected Long id;

    @Getter
    @Setter
    @CreatedDate
    protected LocalDateTime createdAt;

    @Getter
    @Setter
    @LastModifiedDate
    protected LocalDateTime updatedAt;

    @Getter
    @Setter
    @Column
    protected LocalDateTime deletedAt;

    public void refresh() {
        updatedAt = LocalDateTime.now();
    }

    public void delete() {
        deletedAt = LocalDateTime.now();
    }

}
