package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "address")
public class Address extends BaseEntity {


    @Getter
    @Setter
    @Column
    private double latitude;

    @Getter
    @Setter
    @Column
    private double longitude;

    
}
