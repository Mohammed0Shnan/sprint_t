import 'dart:io';
import 'package:client_app/module_products/model/product_model.dart';
import 'package:client_app/module_products/state_manager/batch_bloc.dart';
import 'package:client_app/module_products/state_manager/products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductsBloc _bloc ;
  late final ScrollController _productScrollController ;

  @override
  void initState() {
    _bloc = ProductsBloc();
    _bloc.getProducts();
    _productScrollController = ScrollController();
    _productScrollController.addListener(_productScrollListener);
    super.initState();
  }

  @override
  void dispose() {
     _bloc.close();
    _productScrollController.dispose();
    super.dispose();
  }

  void _productScrollListener() {
    if (_productScrollController.offset == _productScrollController.position.maxScrollExtent &&
        !_productScrollController.position.outOfRange) {
      _bloc.fetchNextIdeas();
    }
  }


  @override
  Widget build(BuildContext context) {
 //   var connectivityBloc = context.read<InternetService>();
    return  Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title:   Text('Products',style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
        elevation: 0,
      ),
      body: SafeArea(
        child:  getProducts()
      ),


    );


  }
  Future<void> onRefreshIdeas()async {
    _bloc.getProducts();
  }
  Widget getProducts(){
    return BlocConsumer<ProductsBloc ,ProductsStates >(
        bloc: _bloc,
        listener: (context ,state){
        },
        builder: (maincontext,state) {

          if(state is ProductsErrorState)
            return Center(
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(),
                  child: Text(state.message,style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
                ),
              ),
            );

          else if(state is ProductsSuccessState) {
            List<ProductModel> products = state.products;

            if(products.isEmpty)
              return Center(
                  child:   Text('Empty')
              );
            else
              return RefreshIndicator(
                onRefresh: ()=>onRefreshIdeas(),
                child: Scrollbar(
                  child: ListView.separated(
                    itemCount:products.length +1,
                    controller: _productScrollController,
                    separatorBuilder: (context,index){
                      return SizedBox(height: 8,);
                    },
                    itemBuilder: (context,index){
                      if(index == products.length){
                        return BlocBuilder<BatchBloc,BatchStates>(
                          bloc: _bloc.batchBloc,
                          builder: (BuildContext context, state) {

                            if(state is BatchLoadingState){
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.symmetric(vertical: 32.0),
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: SizedBox(
                                  height: 20,width: 20,
                                  child: Platform.isIOS? CupertinoActivityIndicator():CircularProgressIndicator(),
                                ),
                              );
                            }else if (state is BatchErrorState)
                            {
                              return Center(child: Text('error',textAlign: TextAlign.center,style: TextStyle(fontSize: 13,color: Colors.black54),),);
                            }else if (state is BatchSuccessState)
                            {
                              if(state.length == 0)
                                return Center(child: Text('error',textAlign: TextAlign.center,style: TextStyle(fontSize: 13,color: Colors.black54),),);
                              else  return SizedBox.shrink();
                            }
                            else  return SizedBox.shrink();

                          },);
                      }
                      return  GestureDetector(
                        onTap: (){
                          //Navigator.pushNamed(context, ProductsRoutes.PRODUCTS_SCREEN,arguments: questions[index].id);
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius:1,
                                  spreadRadius: 1
                              )
                            ],
                            color:   Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Text(products[index].name)
                        ),
                      );
                    },
                  ),
                ),
              );}
          else  return Center(
              child: Container(
                width: 30,
                height: 30,
                child: Platform.isIOS?CupertinoActivityIndicator(): CircularProgressIndicator(),
              ),
            );

        }
    );
  }


}
