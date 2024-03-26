import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/salonmodels/checkHizmetmodel.dart';
import 'package:salonmate/widgets/cards/servicelistcard.dart';
import 'package:salonmate/widgets/custom/mateslider.dart';
import 'package:salonmate/widgets/loader.dart';

class RandevuMainScreen extends StatefulWidget {
  const RandevuMainScreen({super.key});

  @override
  State<RandevuMainScreen> createState() => _RandevuMainScreenState();
}

class _RandevuMainScreenState extends State<RandevuMainScreen> {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Randevu Oluştur",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold),
              ),
            ],
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
              MateSlider(),
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
