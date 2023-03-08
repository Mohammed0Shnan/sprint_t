

import 'package:client_app/consts/urls.dart';
import 'package:client_app/module_network/http_client/http_client.dart';
import 'package:client_app/module_products/response/products_response.dart';

class ProductRepository {
  final client = ApiClient();

  Future<ProductResponse?> getFirstBatchProducts() async {
    var result = await client
        .get(Urls.PRODUCTS_URL, queryParams: {'page': '1', 'size': '5'});

    if (result == null) {
      return null;
    } else {
      return ProductResponse.fromJson(result);
    }
  }

  Future<ProductResponse?> getNextBatchProducts({required int offset}) async {
    var result = await client.get(Urls.PRODUCTS_URL,
        queryParams: {'page': '$offset', 'size': '5'});
    if (result == null) {
      return null;
    } else {
      return ProductResponse.fromJson(result);
    }
  }


}
