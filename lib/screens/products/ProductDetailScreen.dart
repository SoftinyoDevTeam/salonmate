import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:salonmate/widgets/buttons.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  PageController pageController = PageController();
  int currentIndexPage = 0;
  int quantity = 1;
  List<Widget> Sliderlist = [
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
  ];
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
                    "300,90 TL",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              MateButon(
                  title: "Sepete Ekle",
                  minimumSize: Size(50.w, 40.h),
                  onPressed: () async {
                    await PersistentShoppingCart().addToCart(
                        PersistentShoppingCartItem(
                            productThumbnail:
                                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
                            productId: "1",
                            productName: "Nars The Orginal Multi-Purpose Stick",
                            unitPrice: 300.90,
                            quantity: quantity));
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
          "Ürün Adı",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
                child: Container(
              height: 150.h,
              child: ClipRRect(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: Sliderlist.length,
                  itemBuilder: (context, i) {
                    return Container(
                      child: Sliderlist[i],
                    );
                  },
                  onPageChanged: (value) {
                    setState(() => currentIndexPage = value);
                  },
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < Sliderlist.length; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 7,
                      width: i == currentIndexPage ? 20 : 10,
                      decoration: BoxDecoration(
                        color: i == currentIndexPage
                            ? const Color.fromARGB(255, 253, 51, 87)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Nars The Orginal Multi-Purpose Stick",
                    style: TextStyle(fontWeight: FontWeight.w500),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  child: Text(
                    ' Likit Mat Ruj\n 250 ml \n Lorem ipsum sit amed',
                    style: TextStyle(fontWeight: FontWeight.w400),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Teslimat Seçenekleri",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'UPS Kargo',
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '12.00 TL',
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.discount),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Kampanyalar",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
