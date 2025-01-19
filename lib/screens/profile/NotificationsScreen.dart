import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/usermodels/bildirimmodel.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/empty.dart';
import 'package:salonmate/widgets/lists/notificationlist.dart';
import 'package:salonmate/widgets/loader.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Bildirim?> notifications = [];
  void getNotifications() async {
    notifications = await notificationlist();
    setState(() {});
  }

  void initState() {
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MateBar(
            "Bildirimler", true, Theme.of(context).colorScheme.secondary),
        body: Column(
          children: [
            notifications.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: EmptyState(
                        image: "assets/images/icons/bell.png",
                        title: "Maalesef",
                        description: "Size gönderilmiş hiçbir bildirim yok."),
                  )
                : SizedBox(
                    height: 500.h,
                    width: ScreenUtil().screenWidth,
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationListCard(
                          title: notifications[index]!.title,
                          message: notifications[index]!.description,
                          createdTime:
                              notifications[index]!.createdDate.toString(),
                        );
                      },
                    ),
                  )
          ],
        ));
  }
}
