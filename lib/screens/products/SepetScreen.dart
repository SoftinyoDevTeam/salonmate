import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/main.dart';

import 'package:salonmate/widgets/buttons.dart';

class SepetScreen extends StatefulWidget {
  const SepetScreen({super.key});

  @override
  State<SepetScreen> createState() => _SepetScreenState();
}

class _SepetScreenState extends State<SepetScreen> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outline,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Text(
              "Sepetim",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).colorScheme.outline,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Dismissible(
              direction: DismissDirection.endToStart,
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });
              },
              // Show a red background as the item is swiped away.
              background: Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 22.0),
                      child: Text(
                        "Kaldır",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    )
                  ],
                ),
              ),
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColorLight),
                width: ScreenUtil().screenWidth,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          border: Border.all(
                              width: 1.sp,
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                              height: 90.h,
                              width: 90.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        "assets/images/backgrounds/sallakazan.png",
                                      )),
                                  borderRadius: BorderRadius.circular(12.sp))),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          "data",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          "203,00 TL",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(spreadRadius: 1, color: Colors.grey.withOpacity(0.2))
            ]),
        height: 65.h,
        width: ScreenUtil().screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Toplam",
                    style: TextStyle(fontSize: 8.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "354,21 TL",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                      Icon(
                        Icons.arrow_drop_up_rounded,
                        size: 28.sp,
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                    ],
                  ),
                ],
              ),
              MateButon(
                  title: "Sepeti Onayla",
                  minimumSize: Size(20.w, 40.h),
                  onPressed: () {},
                  color: Theme.of(context).primaryColor,
                  textcolor: Theme.of(context).primaryColorLight)
            ],
          ),
        ),
      ),
    );
  }
}
