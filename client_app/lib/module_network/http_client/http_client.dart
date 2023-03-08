


import 'package:client_app/consts/urls.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  String? token;
  final String tag = 'ApiClient';

  final _client = Dio(BaseOptions(
    sendTimeout: 60000,
    receiveTimeout: 60000,
    connectTimeout: 60000,
    baseUrl: Urls.BASE_URL,
  ));


  Future<Map<String, dynamic>?> get(
    String url, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
  


      if (headers != null) {
        if (headers['Authorization'] != null) {
          _client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      print('************************');
      print(url);
      var response = await _client.get(
        url,
        queryParameters: queryParams,
      );
      print('****************************1');
      print(response);

      return _processResponse(response);
    } catch (e) {
      print(e);
      return null;
    }
  }


  Map<String, dynamic>? _processResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return {
        'items': response.data
      };
    } else if (response.statusCode! <= 400 && response.statusCode! < 500) {
      return null;
    } else {
  
      return null;
    }
  }
}
