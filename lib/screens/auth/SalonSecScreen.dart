import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ios_keyboard_action/ios_keyboard_action.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/screens/auth/SplashScreen.dart';
import 'package:salonmate/widgets/buttons.dart';

class SalonSecScreen extends StatefulWidget {
  const SalonSecScreen({super.key});

  @override
  State<SalonSecScreen> createState() => _SalonSecScreenState();
}

class _SalonSecScreenState extends State<SalonSecScreen> {
  TextEditingController pincontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      image: DecorationImage(
                          image: AssetImage("assets/appicon/mate.png"))),
                )
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Text(
                "SalonSecScreen.enter_code".tr(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  autofocus: true,
                  defaultPinTheme: deviceType == "tablet"
                      ? defaultPinThemetablet
                      : defaultPinThemetablet,
                  controller: pincontroller,
                  length: 6,
                  onCompleted: (value) async {
                    var token = await findSalonToken(pincontroller.text);
                    if (token == null) {
                      Fluttertoast.showToast(
                          msg: "SalonSecScreen.wrong_salon_code".tr());
                    } else {
                      mateKey = token;
                      await Provider.of<MateServices>(context, listen: false)
                          .changeThemeData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            MateButon(
                color: "#FD3553".toColor(),
                textcolor: Colors.white,
                title: ("general.login").tr(),
                minimumSize: const Size.fromHeight(50),
                onPressed: () async {})
          ],
        ),
      ))),
    );
  }
}
