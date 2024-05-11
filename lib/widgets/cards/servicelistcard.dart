import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/models/othermodels/radioselectmodels.dart';
import 'package:salonmate/core/models/salonmodels/checkHizmetmodel.dart';
import 'package:salonmate/screens/randevu/ScheduleScreen.dart';
import 'package:salonmate/widgets/bottomsheets/radioselectbottomsheets.dart';
import 'package:salonmate/widgets/loader.dart';

class ServiceListCard extends StatefulWidget {
  final double radius;
  final String imageUrl;
  final String text;
  final List<HizmetModel> hizmetler;

  const ServiceListCard(
      {super.key,
      required this.radius,
      required this.imageUrl,
      required this.text,
      required this.hizmetler});

  @override
  State<ServiceListCard> createState() => _ServiceListCardState();
}

class _ServiceListCardState extends State<ServiceListCard> {
  RadioSelectModels? subeSecimi;
  @override
  Widget build(BuildContext context) {
    subeSecimi != null
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScheduleScreen(
                      hizmetler: widget.hizmetler,
                      kategori: widget.text,
                      cuzdanrandevusu: false,
                    )))
        : ();
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScheduleScreen(
                      hizmetler: widget.hizmetler,
                      kategori: widget.text,
                      cuzdanrandevusu: false)));
        },
        child: CachedNetworkImage(
          height: 132.w,
          width: 110.w,
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.imageUrl,
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                ],
              )),
          placeholder: (context, url) => Loader(),
          errorWidget: (context, url, error) => Icon(Icons.error_outline),
        ));
  }
}
