
import 'dart:async';
import 'package:client_app/module_products/model/product_model.dart';
import 'package:client_app/module_products/service/product_service.dart';
import 'package:client_app/module_products/state_manager/batch_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent,ProductsStates>{
  final ProductService _service = ProductService();
  final BatchBloc _batchBloc = BatchBloc();

  get batchBloc => _batchBloc;
  ProductsBloc() : super(ProductsLoadingState()) {

    on<ProductsEvent>((ProductsEvent event, Emitter<ProductsStates> emit) {
      if (event is ProductsLoadingEvent)
        {
          emit(ProductsLoadingState());

        }
      else if (event is ProductsErrorEvent){
        emit(ProductsErrorState(message: event.message));
      }

      else if (event is ProductsSuccessEvent){
        emit(ProductsSuccessState(products: event.producs,message: null));
      }


    });
    getProducts();
  }



  void getProducts() {

     this.add(ProductsLoadingEvent());
     _service.productsPublishSubject.listen((value) {

       if(value != null){
         this.add(ProductsSuccessEvent(producs: value));

       }else
       {
         this.add(ProductsErrorEvent(message: 'Error In Fetch Data !!'));
       }
     });
     _service.getProducts();
  }


  /// Page Init
 void fetchNextIdeas()  {
   _batchBloc.emitLoadingState();
   _service.fetchNextProducts().then((value) {
      if(value){
        _batchBloc.emitInitState();
      }else{
        _batchBloc.emitErrorState();
      }
    });
  }


  @override
  Future<void> close() {
    print('close pending stream from bloc layer++++++++++++++++++++++');
    _batchBloc.close();
    _service.closeStreams();
    return super.close();
  }
}


abstract class ProductsEvent { }
class ProductsInitEvent  extends ProductsEvent  {}

class ProductsSuccessEvent  extends ProductsEvent  {
  List<ProductModel>  producs;
  ProductsSuccessEvent({required this.producs});
}
class ProductsLoadingEvent  extends ProductsEvent  {}

class ProductsErrorEvent  extends ProductsEvent  {
  String message;
  ProductsErrorEvent({required this.message});
}

class CaptainOrderDeletedErrorEvent  extends ProductsEvent  {
  String message;
  CaptainOrderDeletedErrorEvent({required this.message});
}




abstract class ProductsStates {}

class ProductsInitState extends ProductsStates {}

class ProductsSuccessState extends ProductsStates {
  List<ProductModel>  products;

  String? message;
  ProductsSuccessState({required this.products,required this.message});
}
class ProductsLoadingState extends ProductsStates {}

class ProductsErrorState extends ProductsStates {
  String message;
  ProductsErrorState({required this.message});
}






