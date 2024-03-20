import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shake/shake.dart';

class SallaKazanScreen extends StatefulWidget {
  const SallaKazanScreen({super.key});

  @override
  State<SallaKazanScreen> createState() => _SallaKazanScreenState();
}

class _SallaKazanScreenState extends State<SallaKazanScreen> {
  ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
    Fluttertoast.showToast(msg: "Bu sefer hiçbirşey kazanamadınız.");
    exit(1);
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
