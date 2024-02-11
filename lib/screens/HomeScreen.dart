import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/widgets/products/productlistcard.dart';

class SalonmateHomeScreen extends StatefulWidget {
  const SalonmateHomeScreen({super.key});

  @override
  State<SalonmateHomeScreen> createState() => _SalonmateHomeScreenState();
}

class _SalonmateHomeScreenState extends State<SalonmateHomeScreen> {
  PageController pageController = PageController();
  int currentIndexPage = 0;
  List<Widget> Sliderlist = [
    Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp)),
        child: Image.network(
            "https://www.softinyo.com/guzellik-merkezi/kazandiran_arkadaslik.png")),
    Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.sp)),
        child: Image.network(
            "https://www.softinyo.com/guzellik-merkezi/urun_kampanyasi.png")),
    Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.sp)),
        child: Image.network(
            "https://www.softinyo.com/guzellik-merkezi/salla_kazan.png")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              height: 200.h,
              width: ScreenUtil().screenWidth,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                scrollDirection: Axis.vertical,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: salonConfig!.data!.salonConfig!.livechat == "yes"
            ? FloatingActionButton(
                onPressed: () {},
                splashColor: Colors.blue,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Image.asset(
                    "assets/images/icons/online.gif",
                    height: 60,
                    width: 60,
                  ),
                ))
            : Container(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Left menu item
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40.h,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/home.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Anasayfa',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40.h,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/product.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Ürünler',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              // Right menu item
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/appointment.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Randevu',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/basket.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Sepet',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
