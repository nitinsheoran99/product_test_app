import 'package:product_test_app/model/products_model.dart';

class ProductResponseList {
  List<Products> products;

  ProductResponseList({required this.products});

  factory ProductResponseList.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List;
    List<Products> productList = productsJson.map((product) => Products.fromJson(product)).toList();

    return ProductResponseList(products: productList);
  }
}
