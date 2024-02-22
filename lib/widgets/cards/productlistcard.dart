import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';

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
            width: width - (width / 50),
            height: height - (height / 50),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
            child: Image.network(imageUrl),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Text.rich(TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: 'Nars',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  TextSpan(
                    text: ' The Orginal Multi-Purpose Stick',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ])))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(price.toString() + " " + currency,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.secondary)),
          )
        ],
      ),
    );
  }
}
