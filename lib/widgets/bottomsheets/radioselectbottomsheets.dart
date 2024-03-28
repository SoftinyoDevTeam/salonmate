import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/radioselectmodels.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/loader.dart';

void RadioSelectBottomSheet(BuildContext context, bool imageColumn,
    bool titleColumn, String module, FormData formData, Function onSelected,
    {String title = "Seçiminizi Yapın"}) async {
  RadioSelectModels? selectedItems;
  List<RadioSelectModels?> data = [];
  bool isfetch = false;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Container(
          height: ScreenUtil().screenHeight / 1.6,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            void fetchData() async {
              data = await checkRadioList(module, formData);
              isfetch = true;
              setState(
                () {},
              );
            }

            if (isfetch == false) {
              fetchData();
            }

            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
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
                        data.length == 0
                            ? Loader()
                            : Column(
                                children: [
                                  for (var item in data)
                                    GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            selectedItems = item;
                                          },
                                        );
                                        onSelected(selectedItems);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: selectedItems == item
                                              ? BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                )
                                              : BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 224, 224, 228)),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    imageColumn == true
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                item!.imageUrl!,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    titleColumn == true
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              item!.fullName!,
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                IconButton(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        selectedItems = item!;
                                                      },
                                                    );
                                                  },
                                                  icon: selectedItems == item
                                                      ? Icon(
                                                          Icons
                                                              .radio_button_checked,
                                                        )
                                                      : Icon(
                                                          Icons.circle_outlined,
                                                        ),
                                                ),
                                              ])),
                                    ),
                                ],
                              )
                      ]),
                    ),
                  ]),
            );
          }),
        );
      });
}
