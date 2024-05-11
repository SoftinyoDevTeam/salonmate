import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/salonmodels/salonproductsmodel.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';

import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final SalonProductsModel product;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80.h,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Toplam",
                    style: TextStyle(
                        fontSize: 8.sp,
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    widget.product.price.toString() + " TL",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              MateButon(
                  title: "Sepete Ekle",
                  minimumSize: Size(50.w, 40.h),
                  onPressed: () async {
                    String? userToken = await getPrefString("token");
                    bool status =
                        await addToCart(widget.product.ID!, "URUN", userToken!);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenBridge(
                            selectedScreen: 3,
                          ),
                        ),
                        (route) => false);
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Theme.of(context).primaryColorLight)
            ],
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).dialogBackgroundColor,
          ),
        ),
        title: Text(
          widget.product.name!,
          style: TextStyle(
            fontSize: 15.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                  child: Container(
                      height: 150.h,
                      child: MateImage(
                        imageUrl: widget.product.imgUrl,
                        boxFit: BoxFit.cover,
                      ))),
              Divider(
                color: Theme.of(context).colorScheme.outline,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.name!.length > 44
                          ? widget.product.name!.substring(0, 44) + "..."
                          : widget.product.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.outline,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Ürün Özellikleri",
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: ScreenUtil().screenWidth - 50,
                      child: Text(
                        widget.product.description!,
                        maxLines: 10,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),

              Divider(
                color: Theme.of(context).colorScheme.outline,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Teslimat Seçenekleri",
              //         style: TextStyle(fontWeight: FontWeight.w600),
              //         textAlign: TextAlign.start,
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         'UPS Kargo',
              //         style: TextStyle(fontWeight: FontWeight.w400),
              //         textAlign: TextAlign.start,
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         '12.00 TL',
              //         style: TextStyle(fontWeight: FontWeight.w400),
              //         textAlign: TextAlign.start,
              //       ),
              //     ),
              //   ],
              // ),
              // Divider(
              //   color: Theme.of(context).colorScheme.outline,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Adet Seçiniz',
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.remove,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.outline,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.discount),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Kampanyalar",
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salonConfig!.data!.salonConfig!.urunkampanyatext!),
              ),
              Divider(
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
