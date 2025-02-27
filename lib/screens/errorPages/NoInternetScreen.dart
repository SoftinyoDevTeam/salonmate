import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "NoInternetScreen.check_connection".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24.sp, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: ScreenUtil().screenWidth - 49.w,
                        height: 300.h,
                        child: Image.asset(
                          "assets/images/icons/no-internet.gif",
                          fit: BoxFit.fill,
                        ))
                  ],
                ),
              ],
            )));
  }
}
