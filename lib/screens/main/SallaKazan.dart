import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';

import 'package:shake_detector/shake_detector.dart';

class SallaKazanScreen extends StatefulWidget {
  const SallaKazanScreen({super.key});

  @override
  State<SallaKazanScreen> createState() => _SallaKazanScreenState();
}

class _SallaKazanScreenState extends State<SallaKazanScreen> {
  ShakeDetector detector = ShakeDetector.waitForStart(
      shakeThresholdGravity: 1,
      minimumShakeCount: 3,
      shakeSlopTimeMS: 1000,
      onShake: () {
        shakeWin();
      });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    detector.startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detector.stopListening();
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
