import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/screens/main/SallaKazan.dart';
import 'package:salonmate/screens/profile/CuzdanimScreen.dart';

class SallaKazanSonuc extends StatefulWidget {
  const SallaKazanSonuc({super.key, required this.message});
  final String message;
  @override
  State<SallaKazanSonuc> createState() => _SallaKazanSonucState();
}

class _SallaKazanSonucState extends State<SallaKazanSonuc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenHeight,
              child:
                  Image.asset("assets/images/backgrounds/salla_kazan_2_1.png")),
          Align(
              alignment: Alignment.center,
              child:
                  Image.asset("assets/images/backgrounds/salla_kazan_2_2.png")),
          Positioned(
              bottom: 120.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 60.h,
                      width: ScreenUtil().screenWidth - 40.w,
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuzdanimScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber),
                        height: 30.h,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Hediye Hizmetlerime Git",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 60),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 34.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
