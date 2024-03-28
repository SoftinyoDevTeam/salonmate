import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/salonmodels/productcategorymodel.dart';
import 'package:salonmate/core/models/salonmodels/salonproductsmodel.dart';
import 'package:salonmate/screens/products/ProductCategoryScreen.dart';
import 'package:salonmate/widgets/cards/productcategorycard.dart';
import 'package:salonmate/widgets/custom/mateslider.dart';
import 'package:salonmate/widgets/loader.dart';

class ProductsMainScreen extends StatefulWidget {
  const ProductsMainScreen({super.key});

  @override
  State<ProductsMainScreen> createState() => _ProductsMainScreenState();
}

class _ProductsMainScreenState extends State<ProductsMainScreen> {
  List<ProductCategoryModel?> urunler = [];

  void geturunler() async {
    urunler = await procat();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geturunler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Ürünler",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Kampanyalar",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700),
                ),
              ),
              MateSlider(),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 14),
                child: Text(
                  "Ürünler",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700),
                ),
              ),
              urunler.isEmpty
                  ? Loader()
                  : SizedBox(
                      height: 300.h,
                      width: ScreenUtil().screenWidth,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemCount: urunler.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductCategoryScreen(
                                                products:
                                                    urunler[index]!.list!)));
                              },
                              child: ProductCategoryListCard(
                                text: urunler[index]!.catname!,
                                imageUrl: urunler[index]!.imgUrl!,
                                radius: 15.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ));
  }
}
