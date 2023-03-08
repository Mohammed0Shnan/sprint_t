package com.example.demo.algorethims;

import com.example.demo.entity.Product;

public class ProductNode {
    public Product product;
    public ProductNode left;
    public ProductNode right;

    public ProductNode(Product p)
    {
        product = p;
        left = right = null;
    }
}