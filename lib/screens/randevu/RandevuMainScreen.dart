import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/salonmodels/checkHizmetmodel.dart';
import 'package:salonmate/widgets/cards/servicelistcard.dart';
import 'package:salonmate/widgets/loader.dart';

class RandevuMainScreen extends StatefulWidget {
  const RandevuMainScreen({super.key});

  @override
  State<RandevuMainScreen> createState() => _RandevuMainScreenState();
}

class _RandevuMainScreenState extends State<RandevuMainScreen> {
  PageController pageController = PageController();
  int currentIndexPage = 0;
  List<Widget> Sliderlist = [
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
    Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/beauty-campaigns-celebrating-ageing-revolution-conceal-and-define-1536834974.jpg",
              ))),
    ),
  ];
  List<HizmetKategoriModel?> hizmetler = [];
  void getServices() async {
    hizmetler = await checkHizmetler();
    setState(() {});
    log(hizmetler.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Randevu Oluştur",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Kampanyalar",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                  child: Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.h),
                ),
                height: 150.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.h),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: Sliderlist.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Sliderlist[i],
                      );
                    },
                    onPageChanged: (value) {
                      setState(() => currentIndexPage = value);
                    },
                  ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < Sliderlist.length; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 7,
                      width: i == currentIndexPage ? 20 : 10,
                      decoration: BoxDecoration(
                        color: i == currentIndexPage
                            ? const Color.fromARGB(255, 253, 51, 87)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 14),
                child: Text(
                  "Hizmetler",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700),
                ),
              ),
              hizmetler.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Loader(),
                    )
                  : SizedBox(
                      height: 300.h,
                      width: ScreenUtil().screenWidth,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemCount: hizmetler.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ServiceListCard(
                              hizmetler: hizmetler[index]!.list!,
                              text: hizmetler[index]!.name!,
                              imageUrl:
                                  "https://www.newwell.com.tr/Data/Blog/30.jpg",
                              radius: 15.sp,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ));
  }
}
