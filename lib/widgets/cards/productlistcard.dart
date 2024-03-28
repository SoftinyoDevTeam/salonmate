import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final double width;
  final double height;
  final VoidCallback onPressed;
  const ProductCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onPressed,
      required this.price,
      required this.width,
      required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E4)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
              width: 150.w,
              height: 150.w,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MateImage(
                  imageUrl: imageUrl,
                  boxFit: BoxFit.contain,
                ),
              )),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Text.rich(TextSpan(children: <InlineSpan>[
                  // TextSpan(
                  //   text: 'Wella ',
                  //   style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold,
                  //       color: Theme.of(context).colorScheme.primary),
                  // ),
                  TextSpan(
                    text: title.length > 30
                        ? title.substring(0, 30) + "..."
                        : title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ])))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(price.toString() + " " + currency,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.secondary)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
