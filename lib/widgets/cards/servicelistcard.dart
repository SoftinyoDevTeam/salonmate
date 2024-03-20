import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/bottomsheets/radioselectbottomsheets.dart';

class ServiceListCard extends StatefulWidget {
  final double radius;
  final String imageUrl;
  final String text;
  const ServiceListCard(
      {super.key,
      required this.radius,
      required this.imageUrl,
      required this.text});

  @override
  State<ServiceListCard> createState() => _ServiceListCardState();
}

class _ServiceListCardState extends State<ServiceListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RadioSelectBottomSheet(context, "imageUrl", "fullName", "getStaffs",
            FormData.fromMap({"subeID": "1"}));
      },
      child: Container(
          height: 132.w,
          width: 110.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            ],
          )),
    );
  }
}
