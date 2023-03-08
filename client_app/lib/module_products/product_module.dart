
import 'package:client_app/abstracts/module/my_module.dart';
import 'package:client_app/module_products/product_routes.dart';
import 'package:client_app/module_products/ui/screens/products_screen.dart';
import 'package:flutter/material.dart';

class ProductsModule extends MyModule {

  final ProductsScreen _productsScreen;

  ProductsModule(
this._productsScreen

  ) ;

  Map<String, WidgetBuilder> getRoutes() {
    return {

      ProductsRoutes.PRODUCTS_SCREEN: (context) => _productsScreen,

    };
  }
}
