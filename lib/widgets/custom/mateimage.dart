import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/loader.dart';

class MateImage extends StatelessWidget {
  const MateImage({super.key, this.imageUrl, this.boxFit = BoxFit.fill});
  final imageUrl;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: boxFit,
        placeholder: (context, url) => Loader(),
        errorWidget: (context, url, error) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.hide_image_outlined),
                Text(
                  "Görsel Hazırlanıyor",
                  style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
                )
              ],
            ));
  }
}
