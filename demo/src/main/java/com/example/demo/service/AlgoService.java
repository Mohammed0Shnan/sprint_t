package com.example.demo.service;


import com.example.demo.algorethims.ProductNode;
import com.example.demo.algorethims.TraversalBinaryTree;
import com.example.demo.entity.Product;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlgoService {
    private TraversalBinaryTree binaryTree = new TraversalBinaryTree();
   public void printProducts(List<Product> products){
       ProductNode root  = insertNode(products , 0);
       binaryTree.root = root;
       binaryTree.printPostorder();
   }
    private ProductNode insertNode(List<Product> products, int i)
    {
        ProductNode root = null;

        if (i < products.size()) {
            root = new ProductNode(products.get(i));

            root.left = insertNode(products, 2 * i + 1);
            root.right = insertNode(products, 2 * i + 2);
        }
        return root;
    }
}
