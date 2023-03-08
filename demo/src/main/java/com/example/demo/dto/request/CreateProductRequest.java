package com.example.demo.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@NoArgsConstructor
@AllArgsConstructor
@Getter
public class CreateProductRequest {
    @NotNull(message = "Name can't be null")
    private String name;
    private String imageUrl;
    private CreateAddressRequest addressRequest;
}
