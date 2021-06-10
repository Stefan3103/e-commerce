import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
    this.leftPadding = 20,
  }) : super(key: key);

  final double width, aspectRetio, leftPadding;
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void getCurrentUser() async {
    setState(() {
      widget.product.isFavourite = false;
    });
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email + " " + loggedInUser.uid);
      }
    } catch (e) {
      print(e);
    }
  }
  User loggedInUser;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  bool favorite;

  void isItFavorite() async{
    dynamic size, docId;
    favorite = false;
    try{
      // DocumentSnapshot ds = await _fireStore.collection("favorites").doc("${widget.product.id}").get();
      await  _fireStore.collection("favorites").where("user id", isEqualTo: "${loggedInUser.uid}").where("product id", isEqualTo: "${widget.product.id}").get().then((snap) => {size = snap.size});

      // CollectionReference fav = _fireStore.collection("favorites");
      //
      // DocumentSnapshot ds = await fav.doc()("user id", isEqualTo: "${loggedInUser.uid}").where("${widget.product.id}");

      print(size);

      if(size == 1){
        setState(() {
          widget.product.isFavourite = true;
        });

      }

      else {

        setState(() {
          widget.product.isFavourite = false;
        });


      }

    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    isItFavorite();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(widget.leftPadding)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: widget.product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: widget.aspectRetio,
                child: Container(

                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget.product.id.toString(),
                    child: Image.network(widget.product.image),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () async {
                      dynamic size, docId;
                      if (widget.product.isFavourite == true){
                      setState(()  {
                        widget.product.isFavourite = false;
                      });
                      await _fireStore.collection("favorites").where("user id", isEqualTo: "${loggedInUser.uid}").where("${widget.product.id}").get().then((snap) => {docId = snap.docs.first.id});
                      print(size);
                      print(docId);
                      await _fireStore.collection("favorites").doc("$docId").delete();
                      }
                      else{
                        setState(()  {
                          widget.product.isFavourite = true;
                        });
                        await _fireStore.collection("favorites").doc().set({"user id" : loggedInUser.uid, "product id" : widget.product.id});
                      }

                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: widget.product.isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: widget.product.isFavourite
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
