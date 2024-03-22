import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/salonmodels/salonproductsmodel.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/screens/profile/CuzdanimScreen.dart';
import 'package:salonmate/screens/main/SallaKazan.dart';
import 'package:salonmate/screens/products/ProductDetailScreen.dart';
import 'package:salonmate/screens/profile/NotificationsScreen.dart';
import 'package:salonmate/screens/profile/ProfileScreen.dart';
import 'package:salonmate/widgets/cards/productlistcard.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';
import 'package:salonmate/widgets/loader.dart';

class SalonmateHomeScreen extends StatefulWidget {
  const SalonmateHomeScreen({super.key});

  @override
  State<SalonmateHomeScreen> createState() => _SalonmateHomeScreenState();
}

class _SalonmateHomeScreenState extends State<SalonmateHomeScreen> {
  List<SalonProductsModel?> products = [];
  void awaitgetProducts() async {
    products = await getProducts();
    setState(() {});
  }

  PageController pageController = PageController();
  PageController pageController2 = PageController();
  int currentIndexPage = 0;
  int currentIndexPage2 = 0;
  List<Widget> Sliderlist = [
    Container(
      width: ScreenUtil().screenWidth,
      child: MateImage(
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
      ),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      child: MateImage(
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
      ),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      child: MateImage(
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
      ),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      child: MateImage(
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
      ),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      child: MateImage(
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
      ),
    ),
  ];
  List<Widget> Sliderlist2 = [
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    awaitgetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: ScreenUtil().screenWidth / 1.5,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 4,
                                borderRadius: BorderRadius.circular(45.sp),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).dialogBackgroundColor,
                                    width: 1)),
                            prefixIconColor:
                                Theme.of(context).dialogBackgroundColor,
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Ürün arayın"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()));
                      },
                      child: Icon(Icons.person,
                          color: Theme.of(context).dialogBackgroundColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const NotificationScreen())));
                      },
                      child: Icon(Icons.notifications,
                          color: Theme.of(context).dialogBackgroundColor),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.outline,
                              surfaceTintColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CuzdanimScreen()));
                            },
                            icon: Image.asset(
                              "assets/images/icons/wallet.png",
                              width: 24,
                              height: 24,
                            ),
                            label: Text("Cüzdanım",
                                style: TextStyle(
                                    color: const Color(0xFF272E54),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor:
                                  Theme.of(context).colorScheme.outline,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SallaKazanScreen()),
                              );
                            },
                            icon: Image.asset(
                              "assets/images/icons/shakewin.png",
                              width: 24,
                              height: 24,
                            ),
                            label: Text("Salla Kazan",
                                style: TextStyle(
                                    color: const Color(0xFF272E54),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kampanyalar',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Tümünü Gör',
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat")),
                      )
                    ]),
              ),
              SizedBox(
                  child: Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.h),
                ),
                height: 150.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.h),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: Sliderlist.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Sliderlist[i],
                      );
                    },
                    onPageChanged: (value) {
                      setState(() => currentIndexPage = value);
                    },
                  ),
                ),
              )),
              Row(
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
              SizedBox(
                  child: Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.h),
                ),
                height: 150.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.h),
                  child: PageView.builder(
                    controller: pageController2,
                    itemCount: Sliderlist2.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Sliderlist2[i],
                      );
                    },
                    onPageChanged: (value) {
                      setState(() => currentIndexPage2 = value);
                    },
                  ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < Sliderlist.length; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 7,
                      width: i == currentIndexPage2 ? 20 : 10,
                      decoration: BoxDecoration(
                        color: i == currentIndexPage2
                            ? const Color.fromARGB(255, 253, 51, 87)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
              products.length >= 0
                  ? SizedBox(
                      height: 500.h,
                      width: ScreenUtil().screenWidth,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductDetailScreen()));
                              log("test");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductCard(
                                  width: 120.w,
                                  height: 80.w,
                                  title: products[index]!.name!,
                                  imageUrl: products[index]!.imgUrl!,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductDetailScreen()));
                                  },
                                  price: products[index]!.price!.toDouble()),
                            ),
                          );
                        },
                      ),
                    )
                  : Loader(),
            ],
          ),
        ),
      ),
    );
  }
}
