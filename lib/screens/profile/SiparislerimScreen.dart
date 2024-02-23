import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/cards/sipariscard.dart';

class SiparislerimScreen extends StatefulWidget {
  const SiparislerimScreen({super.key});

  @override
  State<SiparislerimScreen> createState() => _SiparislerimScreenState();
}

class _SiparislerimScreenState extends State<SiparislerimScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MateBar(
          "Siparişlerim", true, Theme.of(context).colorScheme.secondary),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: ScreenUtil().screenHeight - 90.h,
            child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SiparisWidget(
                  fullName: "04 Ocak 2024",
                  imagePath:
                      "https://img-s1.onedio.com/id-6322238158cec29023e4978a/rev-0/w-600/h-719/f-jpg/s-6443ff84e6769e24df1c00b6a6cfb1d51d00e865.jpg",
                  fiyat: "699,90 TL",
                  urunSayisi: 1,
                  status: "2",
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
