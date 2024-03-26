import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/cards/productcategorycard.dart';
import 'package:salonmate/widgets/cards/servicelistcard.dart';
import 'package:salonmate/widgets/custom/mateslider.dart';

class ProductsMainScreen extends StatefulWidget {
  const ProductsMainScreen({super.key});

  @override
  State<ProductsMainScreen> createState() => _ProductsMainScreenState();
}

class _ProductsMainScreenState extends State<ProductsMainScreen> {
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
              SizedBox(
                height: 300.h,
                width: ScreenUtil().screenWidth,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCategoryListCard(
                        text: "Ürün Adı",
                        imageUrl:
                            "https://www.wella.com/sites/default/files/styles/560x560/public/products/1701174615-wella-koleston-intense-sac-boyasi-73-findik-kabugu.png.webp?itok=U63bqTn0",
                        radius: 15.sp,
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
