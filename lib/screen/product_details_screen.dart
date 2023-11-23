import 'package:flutter/material.dart';
import 'package:product_test_app/model/products_model.dart';
import 'package:product_test_app/screen/liked_product_screen.dart';
import 'package:product_test_app/service/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductDetailsScreen extends StatefulWidget {
  Products productModel;
  ProductDetailsScreen({super.key,required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int isLikedCount=0;
  bool isLiked= true;

  void likedCount()async{
    setState(() {

      isLikedCount = isLiked? isLikedCount +1:isLikedCount-1;
    });
    await SharedPrefService.setLikedCount(widget.productModel.id!.toInt(), isLikedCount);
  }

  void likedProducts()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool value = await SharedPrefService.getProduct();
  isLiked= value;

  bool liked = prefs.getBool(widget.productModel.id.toString()) ?? true;
   isLikedCount = await SharedPrefService.getLikedCount(widget.productModel.id!.toInt());
   setState(() {
     isLiked = liked;
   });
  }

  void unlikedProducts()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    await prefs.setBool(widget.productModel.id.toString(), !isLiked);
    setState(() {
      isLiked= !isLiked;
    });
  }
  @override
  void initState() {
    likedProducts();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const LikedProductsScreen();
          }));
        }, icon: const Icon(Icons.favorite_border_outlined,color: Colors.red,))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Image.network(widget.productModel.images!.first.toString()),
              ListTile(

                title: Text(widget.productModel.title.toString()),
                subtitle: Text("\$${widget.productModel.price.toString()}"),
                  trailing: IconButton(
                    onPressed: () async {
                      setState(() {});
                      unlikedProducts();
                      likedCount();
                      SharedPrefService.setProduct(isLiked);
                      SharedPrefService.updateLikedProducts(widget.productModel, isLiked);
                    },
                    icon: Icon(
                      isLiked ? Icons.thumb_up_alt_outlined : Icons.thumb_up,
                      color: Colors.red,
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(widget.productModel.description.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
