import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/models/salonmodels/salonproductsmodel.dart';
import 'package:salonmate/screens/products/ProductDetailScreen.dart';
import 'package:salonmate/widgets/cards/productlistcard.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({super.key, required this.products});
  final List<SalonProductsModel> products;
  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    log(widget.products.toString());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ürün Listesi",
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: ScreenUtil().screenWidth,
        child: GridView.builder(
          physics: ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                            product: widget.products[index]!)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductCard(
                    width: 120.w,
                    height: 90.w,
                    title: widget.products[index]!.name!,
                    imageUrl: widget.products[index]!.imgUrl!,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                  product: widget.products[index]!)));
                    },
                    price: widget.products[index]!.price!.toDouble()),
              ),
            );
          },
        ),
      ),
    );
  }
}
