import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/services/products_list.dart';
import 'package:shop_app/size_config.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: FutureBuilder<List<Product>>(
        future: ListOfProducts().getProductsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found in this category.'));
          } else {
            return GridView.builder(
              padding:
                  EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: SizeConfig.getProportionateScreenWidth(20),
                crossAxisSpacing: SizeConfig.getProportionateScreenWidth(20),
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: snapshot.data![index]),
            );
          }
        },
      ),
    );
  }
}
