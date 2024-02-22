// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListCard extends StatefulWidget {
  String message;
  String createdTime;

  NotificationListCard({
    Key? key,
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
            top:
                BorderSide(width: 1, color: Color.fromARGB(255, 245, 245, 249)),
          ),
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Text(
                            widget.message,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.createdTime,
                            style: TextStyle(
                                color: Theme.of(context).dialogBackgroundColor),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
