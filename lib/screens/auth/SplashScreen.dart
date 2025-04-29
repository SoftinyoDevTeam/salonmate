import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ios_keyboard_action/ios_keyboard_action.dart';
import 'package:salonmate/core/libs/phone_form_field/src/phone_form_field.dart';
import 'package:salonmate/core/libs/phone_form_field/src/validation/phone_validator.dart';
import 'package:salonmate/core/models/splashmodel.dart';
import 'package:salonmate/screens/auth/LoginScreen.dart';
import 'package:salonmate/widgets/buttons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<SplashModel> splashlist = [];
  List<SplashModel> getWalkThroughList() {
    List<SplashModel> list = [];

    list.add(SplashModel(
        image: 'assets/images/splash/model_one.png',
        title: ('SplashScreen.splash_title_1').tr(),
        subTitle: ('SplashScreen.splash_text_1').tr()));
    list.add(SplashModel(
        image: 'assets/images/splash/model_two.png',
        title: ('SplashScreen.splash_title_2').tr(),
        subTitle: ('SplashScreen.splash_text_2').tr()));
    list.add(SplashModel(
        image: 'assets/images/splash/model_three.png',
        title: ('SplashScreen.splash_title_3').tr(),
        subTitle: ('SplashScreen.splash_text_3').tr()));
    return list;
  }

  void getSlides() async {
    splashlist = await getWalkThroughList();
    setState(() {});
  }

  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;

  @override
  void initState() {
    getSlides();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            splashlist.isEmpty
                ? const CircularProgressIndicator()
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: ScreenUtil().screenWidth,
                        height: ScreenUtil().screenHeight,
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment(0.0, 0.0),
                              end: Alignment(0.0, 1.0),
                              colors: [Colors.black, Colors.transparent],
                              stops: [
                                0.0,
                                0.4,
                              ],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: splashlist.length,
                            itemBuilder: (context, i) {
                              return Image.asset(splashlist[i].image!,
                                  fit: BoxFit.cover);
                            },
                            onPageChanged: (value) {
                              setState(() => currentIndexPage = value);
                            },
                          ),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          bottom: 250.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0; i < splashlist.length; i++)
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 7,
                                  width: i == currentIndexPage ? 20 : 10,
                                  decoration: BoxDecoration(
                                    color: i == currentIndexPage
                                        ? const Color.fromARGB(255, 253, 51, 87)
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                            ],
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().screenHeight / 15,
                                left: 20,
                                right: 20),
                            height: 140.h,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          splashlist[currentIndexPage].title!,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color.fromARGB(
                                                255, 39, 46, 84),
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Montserrat",
                                          ),
                                          textAlign: TextAlign.left),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          splashlist[currentIndexPage]
                                              .subTitle!,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                255, 87, 89, 129),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Montserrat",
                                          ),
                                          textAlign: TextAlign.left),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                MateButon(
                                  color: Theme.of(context).primaryColor,
                                  textcolor:
                                      Theme.of(context).primaryColorLight,
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        enableDrag: true,
                                        builder: (BuildContext context) {
                                          return Container(
                                              height:
                                                  ScreenUtil().screenHeight /
                                                      1.1,
                                              decoration: new BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    new BorderRadius.only(
                                                  topLeft:
                                                      const Radius.circular(
                                                          20.0),
                                                  topRight:
                                                      const Radius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.h),
                                                child: LoginScreen(
                                                  tab: 0,
                                                ),
                                              ));
                                        });
                                  },
                                  title: ("general.login").tr(),
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                SizedBox(height: 8.h),
                                MateButon(
                                    color: Theme.of(context).primaryColorLight,
                                    textcolor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return SingleChildScrollView(
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: Container(
                                                        height: ScreenUtil()
                                                                .screenHeight /
                                                            1.1,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                const Radius
                                                                    .circular(
                                                                    20.0),
                                                            topRight:
                                                                const Radius
                                                                    .circular(
                                                                    20.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 15.h),
                                                          child: LoginScreen(
                                                            tab: 1,
                                                          ),
                                                        ))));
                                          });
                                    },
                                    minimumSize: const Size.fromHeight(50),
                                    title: ("general.register").tr()),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
