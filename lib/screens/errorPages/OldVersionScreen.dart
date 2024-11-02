import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/main.dart';
import 'dart:io' show Platform;

class OldVersionScreen extends StatefulWidget {
  const OldVersionScreen({super.key});

  @override
  State<OldVersionScreen> createState() => _OldVersionScreenState();
}

class _OldVersionScreenState extends State<OldVersionScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: InkWell(
        onTap: () async {
          await EasyLauncher.url(
              url: Platform.isAndroid
                  ? Provider.of<MateServices>(context)
                      .salonConfig!
                      .data!
                      .playStoreLink!
                  : Provider.of<MateServices>(context)
                      .salonConfig!
                      .data!
                      .appStoreLink!,
              mode: Mode.externalApp);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Uygulama Sürümünüz Eski",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Uygulamayı kullanmak için lütfen gerekli güncellemeleri yapınız. Güncelleme yapmak için butona tıklayabilirsiniz.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: ScreenUtil().screenWidth - 49.w,
                    height: 300.h,
                    child: Image.asset(
                      "assets/images/icons/upgrade.gif",
                      fit: BoxFit.fill,
                    ))
              ],
            ),
          ],
        ),
      )),
    ));
  }
}
