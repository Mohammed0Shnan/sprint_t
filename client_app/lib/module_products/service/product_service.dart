
import 'dart:async';
import 'package:client_app/module_products/model/product_model.dart';
import 'package:client_app/module_products/repository/products_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../response/products_response.dart';
class ProductService {
  final  ProductRepository _productRepository = ProductRepository();
  /// Streams
  late final PublishSubject<List<ProductModel>?> productsPublishSubject ;


  /// Cashed Data
  late List<Data> ideaDocumentList ;

  ProductService(){
    productsPublishSubject=  PublishSubject();
    ideaDocumentList = [];

  }

  /// This method will automatically fetch first five elements from the API
  Future<void> getProducts() async {

    var apiResponse = await _productRepository.getFirstBatchProducts();

    var questionsList  = <ProductModel>[];
    if(apiResponse != null){
      ideaDocumentList = [];
      ideaDocumentList.addAll(apiResponse.data);
      ideaDocumentList.forEach((element) {

        questionsList.add(ProductModel(id: element.id,
        name: element.name,
          image: element.image,
          addressId: element.address,
        ));
      });
      if(!productsPublishSubject.isClosed){
        productsPublishSubject.add(questionsList);
      }
    }else {

      /// Exception
      productsPublishSubject.add(null);
    }


  }



 /// This method to fetch the following five items
  Future<bool> fetchNextProducts()async {
    int _offset = (ideaDocumentList.length /5).toInt() +1  ;

    var apiResponse = await _productRepository.getNextBatchProducts(offset:_offset );
    var questionsList  = <ProductModel>[];
    if(apiResponse != null){
      ideaDocumentList.addAll(apiResponse.data);
      ideaDocumentList.forEach((element) {
        questionsList.add(ProductModel(id: element.id,
            name: element.name,
            image: element.image,
            addressId:  element.address,
        ));
      });
      if(!productsPublishSubject.isClosed)
        productsPublishSubject.add(questionsList);


      return true;
    }else {
      return false;
      /// Exception
    }
  }

 
  closeStreams(){
    productsPublishSubject.close();
  }
}

