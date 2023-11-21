import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedProductsScreen extends StatelessWidget {
  const LikedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Products'),
      ),
      body: FutureBuilder<List<String>>(
        future: getLikedProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No liked products yet.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                List<String> details = snapshot.data![index].split(",");
                String title = details[0];
                String price = details[1];
                String discount = details[2];
                String description = details[3];
                String image = details[4];

                return Dismissible(
                  key: Key('$title$index'),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    unlikeProduct(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Image.network(image),
                    title: Text(title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price: \$ $price"),
                        Text("Discount: $discount%"),
                        Text(description),

                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> getLikedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('likedProducts') ?? [];
  }

  void unlikeProduct(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedProducts = prefs.getStringList('likedProducts') ?? [];

    if (index >= 0 && index < likedProducts.length) {
      likedProducts.removeAt(index);
      prefs.setStringList('likedProducts', likedProducts);
    }
  }
}