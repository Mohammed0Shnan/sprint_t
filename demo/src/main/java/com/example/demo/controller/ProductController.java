package com.example.demo.controller;

import com.example.demo.dto.request.CreateProductRequest;
import com.example.demo.dto.response.CreateProductResponse;
import com.example.demo.dto.response.ProductResponse;
import com.example.demo.service.ProductService;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("products")
@Validated
public class ProductController {
    @Autowired
    protected ModelMapper modelMapper;

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public List<ProductResponse> getAllProducts(@RequestParam Integer page  , @RequestParam Integer size) {

        var products = productService.getAll(page,size);
        return modelMapper.map(products, new TypeToken<List<ProductResponse>>() {
        }.getType());
    }
    @PostMapping("/")
    public CreateProductResponse createProduct(@Valid @RequestBody CreateProductRequest request) {
        var product = productService.create(request);
        return modelMapper.map(product, CreateProductResponse.class);
    }
}
