package com.example.demo.service;

import com.example.demo.dto.request.CreateAddressRequest;
import com.example.demo.entity.Address;
import com.example.demo.repository.AddressRepository;
import com.google.common.collect.Iterators;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AddressService {
    @Autowired
    private AddressRepository addressRepository;

    @Transactional
    public Address create(CreateAddressRequest request) {
        var address = new Address();
        address.setLatitude(request.getLatitude());
        address.setLongitude(request.getLongitude());

        return addressRepository.save(address);
    }

// commet
}
