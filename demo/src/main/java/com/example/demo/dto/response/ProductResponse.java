package com.example.demo.dto.response;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class ProductResponse{
    @NotNull
    private Long id;

    @NotNull
    private String name;

    private String imageUrl;
    private AddressResponse address;
}