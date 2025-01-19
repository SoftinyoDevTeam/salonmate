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
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _bottomNavIndex,
                onTap: (value) {
                  setState(() => _bottomNavIndex = value);
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(iconList[0]), label: "Anasayfa"),
                  BottomNavigationBarItem(
                      icon: Icon(iconList[1]), label: "Ürünler"),
                  BottomNavigationBarItem(
                      icon: Icon(iconList[2]), label: "Randevu"),
                  BottomNavigationBarItem(
                      icon: Icon(iconList[3]), label: "Sepetim"),
                ])

            // AnimatedBottomNavigationBar.builder(
            //     itemCount: iconList.length,
            //     tabBuilder: (int index, bool isActive) {
            //       return InkWell(
            //         onTap: () {
            //           log("message");
            //           setState(() => _bottomNavIndex = index);
            //         },
            //         child: Container(
            //           height: 40.h,
            //           width: 40.h,
            //           child: Icon(
            //             iconList[index],
            //             size: 24,
            //             color: isActive
            //                 ? Theme.of(context).colorScheme.secondary
            //                 : Theme.of(context).primaryColorDark,
            //           ),
            //         ),
            //       );
            //     },
            //     borderColor: Theme.of(context).colorScheme.outline,
            //     blurEffect: true,
            //     backgroundColor: Theme.of(context).primaryColorLight,
            //     splashColor: Theme.of(context).colorScheme.secondary,
            //     activeIndex: _bottomNavIndex,
            //     gapLocation: GapLocation.center,
            //     notchSmoothness: NotchSmoothness.defaultEdge,
            //     onTap: (index) {
            //       log("message");
            //       setState(() => _bottomNavIndex = index);
            //     }),
            ));
  }
}
