package com.example.demo.service;

import com.example.demo.dto.request.CreateProductRequest;
import com.example.demo.entity.Address;
import com.example.demo.entity.Product;
import com.example.demo.repository.ProductRepository;
import com.google.common.collect.Iterators;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private AddressService addressService;
    @Autowired
    private AlgoService algoService;

    public List<Product> getAll(int size , int page) {
        Sort sort  = Sort.by(Sort.Direction.ASC , "name");
        PageRequest pr = PageRequest.of(page,size,sort);
        var products = productRepository.findAll(pr);
        return   Arrays
                .stream(Iterators.toArray(products.iterator(), Product.class))
                .collect(Collectors.toList());

    }

    @Transactional
    public Product create(CreateProductRequest request) {
        try{
            var product = new Product();
           var address = new Address();
            address.setCreatedAt(LocalDateTime.now());
            product.setCreatedAt(LocalDateTime.now());

            product.setName(request.getName());

            if (request.getImageUrl() != null) {
                product.setImageUrl(request.getImageUrl());
            } else {
                product.setImageUrl(null);
            }


            if (request.getAddress() != null) {
                address.setLatitude(request.getAddress().getLatitude());
                address.setLongitude(request.getAddress().getLongitude());

            } else {
                throw  new Exception();
            }
            Address address1 =  addressService.save(address);
            if(address1 == null)
                throw new Exception();
            product.setAddress(address1);
            return productRepository.save(product);

        }catch (Exception ex){
            return null;
        }

    }


}
