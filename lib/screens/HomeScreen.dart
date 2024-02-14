import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/widgets/cards/productlistcard.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class SalonmateHomeScreen extends StatefulWidget {
  const SalonmateHomeScreen({super.key});

  @override
  State<SalonmateHomeScreen> createState() => _SalonmateHomeScreenState();
}

class _SalonmateHomeScreenState extends State<SalonmateHomeScreen> {
  PageController pageController = PageController();
  int currentIndexPage = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.category_outlined,
    Icons.brightness_6,
    Icons.brightness_7,
  ];

  var _bottomNavIndex = 0; //default index of a first screen
  List<Widget> Sliderlist = [
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
  ];
  List<Widget> Sliderlist2 = [
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F9),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/images/icons/basket.png",
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
                              backgroundColor: const Color(0xFFF5F5F9),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/images/icons/bell.png",
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
                  borderRadius: BorderRadius.circular(24.h),
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
                height: 900.h,
                width: ScreenUtil().screenWidth,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(
                          width: 120.w,
                          height: 80.w,
                          title: "title",
                          imageUrl:
                              "https://sdcdn.io/mac/tr/mac_sku_SK6R01_1x1_0.png?width=1080&height=1080",
                          onPressed: () {},
                          price: 128.99),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40.h,
        width: 40.h,
        child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            backgroundImage: AssetImage("assets/images/icons/online.gif")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.outline,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
