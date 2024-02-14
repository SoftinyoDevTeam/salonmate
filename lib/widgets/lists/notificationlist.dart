import 'package:flutter/material.dart';

class NotificationListCard extends StatefulWidget {
  dynamic element;

  NotificationListCard({required this.element});

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
                    color: Colors.black,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Flexible(child: new Text(widget.element["message"])),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.element["crTime"],
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
