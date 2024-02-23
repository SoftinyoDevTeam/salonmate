// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListCard extends StatefulWidget {
  String? title;
  String? message;
  String? createdTime;

  NotificationListCard({
    Key? key,
    required this.title,
    required this.message,
    required this.createdTime,
  }) : super(key: key);

  @override
  _NotificationListCardState createState() => _NotificationListCardState();
}

class _NotificationListCardState extends State<NotificationListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(width: 1, color: Color.fromARGB(255, 245, 245, 249)),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.black12)),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                          width: ScreenUtil().screenWidth - 70.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              new Text(
                                widget.title!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ],
                          )),
                      Container(
                        width: ScreenUtil().screenWidth - 70.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: new Text(
                                widget.message!,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: ScreenUtil().screenWidth - 70.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.createdTime!,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).dialogBackgroundColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
