import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:shop_app/services/products_list.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/components/product_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ListOfProducts _productService = ListOfProducts();
  List<Product> _products = [];
  List<Product> _searchResults = [];
  bool _isLoading = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await _productService.getProducts();
    setState(() {
      _products = _productService.productList;
      _isLoading = false;
    });
  }

  void _searchProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchResults = _products
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
            HomeHeader(onSearch: _searchProducts),
            SizedBox(height: SizeConfig.getProportionateScreenWidth(10)),
            if (!_isSearching) ...[
              DiscountBanner(),
              Categories(),
              SpecialOffers(),
              SizedBox(height: SizeConfig.getProportionateScreenWidth(30)),
              _isLoading
                  ? CircularProgressIndicator()
                  : PopularProducts(products: _products),
            ] else ...[
              SizedBox(height: SizeConfig.getProportionateScreenWidth(10)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getProportionateScreenWidth(20)),
                child: Text(
                  "Search Results",
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.getProportionateScreenWidth(20)),
              Wrap(
                spacing: SizeConfig.getProportionateScreenWidth(20),
                runSpacing: SizeConfig.getProportionateScreenWidth(20),
                children: List.generate(
                  _searchResults.length,
                  (index) => ProductCard(product: _searchResults[index]),
                ),
              ),
            ],
            SizedBox(height: SizeConfig.getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
