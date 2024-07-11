import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';

class ProductCategoryListCard extends StatefulWidget {
  final double radius;
  final String imageUrl;
  final String text;
  const ProductCategoryListCard(
      {super.key,
      required this.radius,
      required this.imageUrl,
      required this.text});

  @override
  State<ProductCategoryListCard> createState() =>
      _ProductCategoryListCardState();
}

class _ProductCategoryListCardState extends State<ProductCategoryListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: Column(
        children: [
          Container(
            height: 70.h,
            child: MateImage(imageUrl: widget.imageUrl),
          ),
          Text(widget.text,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
