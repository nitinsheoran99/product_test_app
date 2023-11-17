import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:product_test_app/model/product_list.dart';
import 'package:product_test_app/model/products_model.dart';
import 'package:product_test_app/util/api_endPoint.dart';


class ProductApiService{
  static Future<List<Products>> getProductInfo() async {
    String url = ApiEndpoint.baseURl;
    http.Response response = await http.get(
      Uri.parse(url),

    );
    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);

      ProductResponseList productResponseList= ProductResponseList.fromJson(data);
      return productResponseList.products;
    } else {
      throw 'Something went wrong';
    }
  }
}