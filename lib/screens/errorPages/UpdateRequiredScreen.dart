import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:salonmate/core/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icons/upgrade.gif', // Add this asset
                  height: 120.h,
                  width: 120.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30.h),
                Text(
                  'Güncelleme Gerekli',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Uygulamanın yeni bir sürümü mevcut.\n'
                  'Devam etmek için uygulamayı güncellemeniz gerekmektedir.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 40.h),
                ElevatedButton(
                  onPressed: () async {
                    log(Provider.of<MateServices>(context, listen: false)
                        .salonConfig!
                        .data!
                        .playStoreLink!
                        .toString());
                    // Open app store link
                    if (Platform.isAndroid) {
                      final Uri url = Uri.parse(
                          Provider.of<MateServices>(context, listen: false)
                              .salonConfig!
                              .data!
                              .playStoreLink!);
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                    if (Platform.isIOS) {
                      log(Provider.of<MateServices>(context, listen: false)
                          .salonConfig!
                          .data!
                          .playStoreLink!
                          .toString());
                      final Uri url = Uri.parse(
                          Provider.of<MateServices>(context, listen: false)
                              .salonConfig!
                              .data!
                              .appStoreLink!);
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'HEMEN GÜNCELLE',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
