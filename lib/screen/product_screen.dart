import 'package:flutter/material.dart';
import 'package:product_test_app/model/products_model.dart';
import 'package:product_test_app/screen/product_details_screen.dart';
import 'package:product_test_app/service/product_api_response.dart';




class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
   late ProductApiService productApi;
  List<Products> productList = [];

  @override
  void initState() {
    super.initState();
     productApi = ProductApiService();
    loadProducts();
  }

  Future<void> loadProducts() async {
     productList = await ProductApiService.getProductInfo();
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12,crossAxisSpacing: 8
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Products productModel = productList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProductDetailsScreen(productModel: productModel,);
              }),);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                elevation: 6,
                child: Column(
                  children: [
                    Image.network(
                      productModel.images != null && productModel.images!.isNotEmpty
                          ? productModel.images![0]
                          : 'placeholder_url',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    ListTile(
                      title: Text('Name : ${productModel.title}'),
                      subtitle: Text("Price : \$${productModel.price.toString()}"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}