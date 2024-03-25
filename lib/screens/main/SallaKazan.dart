import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/functions.dart';

import 'package:shake_detector/shake_detector.dart';

class SallaKazanScreen extends StatefulWidget {
  const SallaKazanScreen({super.key});

  @override
  State<SallaKazanScreen> createState() => _SallaKazanScreenState();
}

class _SallaKazanScreenState extends State<SallaKazanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
        shakeThresholdGravity: 1,
        minimumShakeCount: 1,
        shakeSlopTimeMS: 1000,
        onShake: () {
          shakeWin();
        });

// start listening later on, after using waitForStart constructor
    detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenHeight,
            child: Image.asset("assets/images/backgrounds/sallakazan.png"))
      ],
    );
  }
}
