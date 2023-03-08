package com.example.demo.dto.response;

import com.example.demo.entity.Address;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class CreateProductResponse  {
    @NotNull
    private Long id;

    @NotNull
    private String name;

    private String imageUrl;
    private Address address;
}
