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
        border: Border.all(color: Theme.of(context).hintColor, width: 1),
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: Column(
        children: [
          Container(
            height: 70.h,
            child: MateImage(imageUrl: widget.imageUrl),
          ),
          Text(
            widget.text,
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
        ],
      ),
    );
  }
}
