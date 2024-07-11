import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/screens/main/CanliDestek.dart';
import 'package:salonmate/screens/main/HomeScreen.dart';
import 'package:salonmate/screens/products/ProductsMainScreen.dart';
import 'package:salonmate/screens/products/SepetScreen.dart';
import 'package:salonmate/screens/profile/NotificationsScreen.dart';
import 'package:salonmate/screens/randevu/RandevuMainScreen.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/matecard.dart';

class ScreenBridge extends StatefulWidget {
  const ScreenBridge({super.key, required this.selectedScreen});
  final int selectedScreen;
  @override
  State<ScreenBridge> createState() => _ScreenBridgeState();
}

class _ScreenBridgeState extends State<ScreenBridge> {
  final TooltipController _controller = TooltipController();
  bool done = false;

  var _bottomNavIndex = 0; //default index of a first screen
  final iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.tag,
    FontAwesomeIcons.calendar,
    FontAwesomeIcons.basketShopping,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavIndex = widget.selectedScreen;

    _controller.onDone(() {
      setState(() {
        done = true;
      });
      setPrefString("tooltip", "false");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      String screen = event.data["screen"];
      switch (screen) {
        case "/notificationscreen":
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NotificationScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget child = Container();
  @override
  Widget build(BuildContext context) {
    switch (_bottomNavIndex) {
      case 0:
        child = SalonmateHomeScreen();
        setState(() {});
        break;
      case 1:
        child = ProductsMainScreen();
        break;
      case 2:
        child = RandevuMainScreen();
        break;
      case 3:
        child = SepetScreen();
        setState(() {});
        break;
      case 4:
        child = CanliDestekScreen();
        setState(() {});
        break;
    }
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return OverlayTooltipScaffold(
        overlayColor: Colors.black,
        tooltipAnimationCurve: Curves.linear,
        tooltipAnimationDuration: const Duration(milliseconds: 1000),
        controller: _controller,
        startWhen: (initializedWidgetLength) async {
          if (await getPrefString("tooltip") == "false") {
            await Future.delayed(const Duration(milliseconds: 500));
            return initializedWidgetLength == 1 && !done;
          } else {
            return false;
          }
        },
        preferredOverlay: GestureDetector(
          onTap: () {
            var next = _controller.nextPlayIndex;
            if (next > 3) {
              _controller.dismiss();
            } else {
              _controller.next();
            }

            //move the overlay forward or backwards, or dismiss the overlay
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(.70),
          ),
        ),
        builder: (context) => Scaffold(
              body: child,
              floatingActionButton: showFab
                  ? OverlayTooltipItem(
                      displayIndex: 0,
                      tooltip: (controller) => Container(
                          width: 200.w,
                          height: 160.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MateCard(
                                widget: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(
                                  "Canlı Destek",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    style: TextStyle(fontSize: 11.sp),
                                    maxLines: 4,
                                    "Her gün 09:00 - 23:00 arası uygulamamız ile ilgili sorularınızı buradan bize iletebilirsiniz.",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: MateButon(
                                      title: "Devam",
                                      minimumSize: Size(30, 30),
                                      onPressed: () {
                                        _controller.next();
                                      },
                                      color: Theme.of(context).primaryColor,
                                      textcolor:
                                          Theme.of(context).primaryColorLight),
                                )
                              ]),
                            )),
                          )),
                      tooltipVerticalPosition: TooltipVerticalPosition.TOP,
                      tooltipHorizontalPosition:
                          TooltipHorizontalPosition.CENTER,
                      child: GestureDetector(
                        onTap: () {
                          _bottomNavIndex = 4;
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 50.h,
                          width: 50.h,
                          child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              backgroundImage:
                                  AssetImage("assets/images/icons/online.gif")),
                        ),
                      ))
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: AnimatedBottomNavigationBar(
                  borderColor: Theme.of(context).colorScheme.outline,
                  blurEffect: true,
                  backgroundColor: Theme.of(context).primaryColorLight,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  splashColor: Theme.of(context).colorScheme.secondary,
                  icons: iconList,
                  inactiveColor: Theme.of(context).primaryColorDark,
                  activeIndex: _bottomNavIndex,
                  gapLocation: GapLocation.center,
                  notchSmoothness: NotchSmoothness.defaultEdge,
                  onTap: (index) {
                    setState(() => _bottomNavIndex = index);
                  }),
            ));
  }
}
