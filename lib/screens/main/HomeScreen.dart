import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/core/models/salonmodels/salonproductsmodel.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/screens/campaigns/CampaingLists.dart';
import 'package:salonmate/screens/profile/CuzdanimScreen.dart';
import 'package:salonmate/screens/main/SallaKazan.dart';
import 'package:salonmate/screens/products/ProductDetailScreen.dart';
import 'package:salonmate/screens/profile/NotificationsScreen.dart';
import 'package:salonmate/screens/profile/ProfileScreen.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/matecard.dart';
import 'package:salonmate/widgets/cards/productlistcard.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';
import 'package:salonmate/widgets/custom/mateslider.dart';
import 'package:salonmate/widgets/loader.dart';

class SalonmateHomeScreen extends StatefulWidget {
  const SalonmateHomeScreen({super.key});

  @override
  State<SalonmateHomeScreen> createState() => _SalonmateHomeScreenState();
}

class _SalonmateHomeScreenState extends State<SalonmateHomeScreen> {
  List<SalonProductsModel?> products = [];
  List<CampaignModel?> kampanyalar = [];
  void awaitgetProducts() async {
    products = await getProducts();
    kampanyalar = await getCampaigns();
    setState(() {});
  }

  PageController pageController = PageController();
  PageController pageController2 = PageController();
  int currentIndexPage = 0;
  int currentIndexPage2 = 0;

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
                      OverlayTooltipItem(
                        displayIndex: 2,
                        tooltip: (controller) => Container(
                            width: 200.w,
                            height: 150.h,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MateCard(
                                  widget: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text(
                                    "Cüzdanım",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      style: TextStyle(fontSize: 11.sp),
                                      maxLines: 4,
                                      "Kampanyalarımızdan elde ettiğiniz kazanımları buradan takip edebilirsiniz.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: MateButon(
                                        title: "Devam",
                                        minimumSize: Size(30, 30),
                                        onPressed: () {},
                                        color: Theme.of(context).primaryColor,
                                        textcolor: Theme.of(context)
                                            .primaryColorLight),
                                  )
                                ]),
                              )),
                            )),
                        tooltipVerticalPosition: TooltipVerticalPosition.BOTTOM,
                        tooltipHorizontalPosition:
                            TooltipHorizontalPosition.CENTER,
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      OverlayTooltipItem(
                        displayIndex: 1,
                        tooltip: (controller) => Container(
                            width: 200.w,
                            height: 150.h,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MateCard(
                                  widget: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text(
                                    "Salla Kazan",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      style: TextStyle(fontSize: 11.sp),
                                      maxLines: 4,
                                      "Telefonunu salla ve süpriz hediyeler kazanma şansını yakala.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: MateButon(
                                        title: "Devam",
                                        minimumSize: Size(30, 30),
                                        onPressed: () {},
                                        color: Theme.of(context).primaryColor,
                                        textcolor: Theme.of(context)
                                            .primaryColorLight),
                                  )
                                ]),
                              )),
                            )),
                        tooltipVerticalPosition: TooltipVerticalPosition.BOTTOM,
                        tooltipHorizontalPosition:
                            TooltipHorizontalPosition.CENTER,
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
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kampanyalar',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => CampaignLists())));
                        },
                        child: const Text('Tümünü Gör',
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat")),
                      )
                    ]),
              ),
              MateSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Öne Çıkan Ürünler",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.sp),
                    ),
                  ),
                ],
              ),
              products.length >= 0
                  ? SizedBox(
                      height: 800.h,
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
                                      builder: (context) => ProductDetailScreen(
                                          product: products[index]!)));
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
                                                ProductDetailScreen(
                                                    product:
                                                        products[index]!)));
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
