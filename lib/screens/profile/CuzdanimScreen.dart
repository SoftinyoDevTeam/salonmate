import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/radioselectmodels.dart';
import 'package:salonmate/core/models/salonmodels/checkHizmetmodel.dart';
import 'package:salonmate/core/models/usermodels/cuzdanimmodel.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:salonmate/screens/randevu/ScheduleScreen.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/empty.dart';
import 'package:salonmate/widgets/loader.dart';

class CuzdanimScreen extends StatefulWidget {
  const CuzdanimScreen({super.key});

  @override
  State<CuzdanimScreen> createState() => _CuzdanimScreenState();
}

class _CuzdanimScreenState extends State<CuzdanimScreen> {
  CuzdanimModel? cuzdanim;
  RadioSelectModels? subeSecimi;
  List<HizmetKategoriModel?> hizmetler = [];
  void getCuzdanim() async {
    hizmetler = await checkHizmetler();
    cuzdanim = await checkCuzdanim();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCuzdanim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenBridge(
                            selectedScreen: 0,
                          )),
                  (route) => false);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).dialogBackgroundColor,
            ),
          ),
          title: Text(
            "Cüzdanım",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(16.h),
              child: Divider(
                color: Theme.of(context).colorScheme.outline,
              ))),
      body: cuzdanim == null
          ? Loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.sp),
                        child: Text(
                          "Puan Bilgisi",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: ScreenUtil().screenWidth - 20,
                    height: 120.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Toplam Puan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            cuzdanim != null
                                ? Text(
                                    cuzdanim!.point.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  )
                                : Text("Yükleniyor",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                            Text(
                              "1 Puan 1 TL'ye eşittir.\n Puanlar gerçek paraya dönüştürülemez, ürün alımlarında kullanılamaz.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: Theme.of(context).disabledColor),
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.sp),
                        child: Text(
                          "Hizmetlerim",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(child: () {
                    if (cuzdanim!.hizmetler!.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: EmptyState(
                            image: "assets/images/icons/appointment.png",
                            title: "Maalesef !",
                            description: "Şuanda aktif hizmetiniz yok"),
                      );
                    }
                    for (int i = 0; i < cuzdanim!.hizmetler!.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80.h,
                          width: ScreenUtil().screenWidth - 20,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.outline),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cuzdanim!.hizmetler![i].name!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      cuzdanim!.hizmetler![i].ney!,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 40.w,
                                        ),
                                        MateButon(
                                            title: "Randevu Al",
                                            minimumSize: Size(20.w, 30.h),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ScheduleScreen(
                                                            selectedService:
                                                                cuzdanim!
                                                                    .hizmetler![i],
                                                            hizmetler: cuzdanim!
                                                                .hizmetler!,
                                                            kategori: cuzdanim!
                                                                .hizmetler![i]
                                                                .name!,
                                                            cuzdanrandevusu:
                                                                true,
                                                            cuzdanID: cuzdanim!
                                                                .hizmetler![i]
                                                                .cuzdanID,
                                                          )));
                                            },
                                            color:
                                                Theme.of(context).primaryColor,
                                            textcolor: Theme.of(context)
                                                .primaryColorLight),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                  }())
                ],
              ),
            ),
    );
  }
}
