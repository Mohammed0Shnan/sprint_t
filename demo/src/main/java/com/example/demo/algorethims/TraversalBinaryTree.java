package com.example.demo.algorethims;

public class TraversalBinaryTree {
   public ProductNode root;

    public TraversalBinaryTree() { root = null; }
    void printPostorder(ProductNode node)
    {
        if (node == null)
            return;
        printPostorder(node.left);
        printPostorder(node.right);
        System.out.print(node.product.getName() + " ");
    }

    public void printPostorder() {
        System.out.println(
                "\nPostorder traversal of binary tree is ");
        printPostorder(root); }
}