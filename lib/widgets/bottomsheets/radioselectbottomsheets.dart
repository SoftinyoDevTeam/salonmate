import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/functions.dart';

void RadioSelectBottomSheet(BuildContext context, String imageColumn,
    String titleColumn, String module, FormData formData,
    {String title = "Seçiminizi Yapın"}) async {
  int selectedTab = 0;

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          dynamic data = "";
          void fetchRadioData() async {
            Response response = await Dio().post(
              apiUrl + "?module=$module",
              data: formData,
              options: Options(
                headers: {
                  "Access-Control-Allow-Origin":
                      "*", // Required for CORS support to work
                  "Matekey": await getPrefString("token"),
                },
              ),
            );

            setState(() {
              data = response.data["data"];
            });
          }

          fetchRadioData();

          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 40.0,
                          height: 5.0,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: Color.fromARGB(255, 188, 188, 188),
                          )),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(children: [
                    for (var item in data)
                      Container(
                          padding: EdgeInsets.only(bottom: 5),
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: selectedTab == 1
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  borderRadius: BorderRadius.circular(12),
                                )
                              : BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 224, 224, 228)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        "",
                                      ),
                                    ),
                                    Text(
                                      " nameList[]",
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: selectedTab == 1
                                      ? Icon(
                                          Icons.radio_button_checked,
                                        )
                                      : Icon(
                                          Icons.circle_outlined,
                                        ),
                                ),
                              ]))
                  ]),
                )
              ]);
        });
      });
}
