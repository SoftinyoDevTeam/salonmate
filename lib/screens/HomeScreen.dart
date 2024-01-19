import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/langs/locale_keys.g.dart';

class SalonmateHomeScreen extends StatefulWidget {
  const SalonmateHomeScreen({super.key});

  @override
  State<SalonmateHomeScreen> createState() => _SalonmateHomeScreenState();
}

class _SalonmateHomeScreenState extends State<SalonmateHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: FloatingActionButton(
            onPressed: () {},
            splashColor: Colors.blue,
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Image.asset(
                "assets/images/icons/online.gif",
                height: 60,
                width: 60,
              ),
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Left menu item
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40.h,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/home.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Anasayfa',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40.h,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/product.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Ürünler',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              // Right menu item
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/appointment.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Randevu',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icons/basket.png",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'Sepet',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
