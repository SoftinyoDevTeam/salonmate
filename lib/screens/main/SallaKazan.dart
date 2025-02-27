import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/screens/main/SallaKazanSonuc.dart';
import 'package:salonmate/widgets/buttons.dart';

import 'package:shake_detector/shake_detector.dart';
import 'package:vibration/vibration.dart';

class SallaKazanScreen extends StatefulWidget {
  const SallaKazanScreen({super.key});

  @override
  State<SallaKazanScreen> createState() => _SallaKazanScreenState();
}

String message = ("SallaKazan.shake_to_win").tr();
late ShakeDetector controller;

class _SallaKazanScreenState extends State<SallaKazanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ShakeDetector.waitForStart(onShake: () async {
      Vibration.vibrate(duration: 1000);

      Vibration.vibrate();
      await Future.delayed(Duration(milliseconds: 500));
      Vibration.vibrate();

      log("salladı");
      message = await shakeWin();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SallaKazanSonuc(message: message)));
      controller.stopListening();
      setState(() {});
    });
    controller.startListening();
    //detector.startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    message = ("SallaKazan.shake_to_win").tr();
    controller.stopListening();
    setState(() {});
    //detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenHeight,
              child: Image.asset("assets/images/backgrounds/sallakazan.png")),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 60),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
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
