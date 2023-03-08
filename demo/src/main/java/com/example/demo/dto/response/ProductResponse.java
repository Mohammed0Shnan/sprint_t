package com.example.demo.dto.response;

import com.example.demo.entity.Address;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class ProductResponse{
    @NotNull
    private Long id;

    @NotNull
    private String name;

    private String imageUrl;
    private Address address_id;
}