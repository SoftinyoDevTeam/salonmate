// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:salonmate/core/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/widgets/buttons.dart';

class LoginScreen extends StatefulWidget {
  final int tab;
  const LoginScreen({
    Key? key,
    required this.tab,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PhoneController phoneController =
      PhoneController(PhoneNumber(isoCode: IsoCode.TR, nsn: ""));
  TextEditingController passController = TextEditingController();

  int selectedTab = 0;
  List<bool> isSelected = <bool>[true, false];
  FocusNode password = FocusNode();
  String email = "";

  @override
  void initState() {
    super.initState();
    selectedTab = widget.tab;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Container(
                      height: 4.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).dialogBackgroundColor,
                          borderRadius: BorderRadius.all(
                              Radius.elliptical(12.sp, 12.sp))))),
              Padding(
                padding: EdgeInsets.all(16.sp),
                child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: Theme.of(context).dialogBackgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectedTab = 0;
                              setState(() {});
                            },
                            child: Container(
                              height: 48.h,
                              width: (ScreenUtil().screenWidth - 56.sp) / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(14.sp, 14.sp)),
                                  color: selectedTab == 0
                                      ? Theme.of(context).primaryColorLight
                                      : Colors.transparent),
                              child: Center(
                                child: Text(
                                  "Giriş Yap",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedTab = 1;
                              setState(() {});
                            },
                            child: Container(
                              height: 48.h,
                              width: (ScreenUtil().screenWidth - 56.sp) / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(14.sp, 14.sp)),
                                  color: selectedTab == 1
                                      ? Theme.of(context).primaryColorLight
                                      : Colors.transparent),
                              child: Center(
                                child: Text(
                                  "Üye Ol",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              selectedTab == 0
                  ? Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 400.h,
                        child: Column(
                          children: [
                            PhoneFormField(
                              decoration:
                                  InputDecoration(hintText: "Telefon Numarası"),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(13),
                              ],
                              controller: phoneController,
                              validator: (phoneNumber) {
                                log(phoneNumber.toString());
                              },
                            ),
                            SizedBox(height: 15.h),
                            TextFormField(
                              decoration: InputDecoration(hintText: "Şifre*"),
                              controller: passController,
                            ),
                            SizedBox(height: 18.h),
                            PembeButon(
                                title: "Giriş Yap",
                                minimumSize: Size.fromHeight(50),
                                onPressed: () {}),
                            SizedBox(height: 18.h),
                            Text("Şifremi Unuttum",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 400.h,
                        child: Column(
                          children: [
                            PhoneFormField(
                              decoration:
                                  InputDecoration(hintText: "Telefon Numarası"),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(13),
                              ],
                              controller: phoneController,
                              validator: (phoneNumber) {
                                log(phoneNumber.toString());
                              },
                            ),
                            Spacer(),
                            PembeButon(
                                title: "Devam Et",
                                minimumSize: Size.fromHeight(50),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
