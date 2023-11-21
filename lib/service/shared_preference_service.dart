
import 'package:product_test_app/model/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static String productKey = 'layout_key';
  static const likedCount = 'likedCount_';

  static Future setLikedCount(int productId, int likedCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$likedCount$productId', likedCount);
  }

  static Future<int> getLikedCount(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$likedCount$productId') ?? 0;
  }

  static Future setProduct(bool isList) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setBool(productKey, isList);
  }

  static Future<bool> getProduct() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    bool value = sf.getBool(productKey) ?? true;
    return value;
  }

  static Future<void> updateLikedProducts(
      Products product, bool isLiked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedProducts = prefs.getStringList('likedProducts') ?? [];
    String productDetails = "${product.title},"
        "${product.price},"
        "${product.discountPercentage},"
        "${product.description},"
        "${product.images!.first}";

    if (isLiked && !likedProducts.contains(productDetails)) {
      likedProducts.add(productDetails);
    } else if (!isLiked) {
      likedProducts.remove(productDetails);
    }

    prefs.setStringList('likedProducts', likedProducts);
  }

// static Future<List<String>> getLikedProducts() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getStringList('likedProducts') ?? [];
// }
}