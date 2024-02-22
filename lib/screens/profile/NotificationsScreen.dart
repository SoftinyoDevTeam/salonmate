import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/lists/notificationlist.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).dialogBackgroundColor,
              ),
            ),
            title: Text(
              "Bildirimler",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(16.h),
                child: Divider(
                  color: Theme.of(context).colorScheme.outline,
                ))),
        body: Column(
          children: [
            SizedBox(
              height: 80.h,
              width: ScreenUtil().screenWidth,
              child: NotificationListCard(
                message: "element",
                createdTime: "2017-12-11",
              ),
            )
          ],
        ));
  }
}
