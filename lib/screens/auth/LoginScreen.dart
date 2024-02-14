// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/screens/HomeScreen.dart';
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
  String phoneNumber = "";
  int selectedTab = 0;
  int registerPage = 0;
  List<bool> isSelected = <bool>[true, false];
  FocusNode password = FocusNode();
  String email = "";
  bool _isRadioSelected = false;
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
                            MateButon(
                                color: Theme.of(context).primaryColor,
                                textcolor: Theme.of(context).primaryColorLight,
                                title: "Giriş Yap",
                                minimumSize: Size.fromHeight(50),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SalonmateHomeScreen(),
                                    ),
                                  );
                                }),
                            SizedBox(height: 18.h),
                            Text("Şifremi Unuttum",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    )
                  : registerPage == 0
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 400.h,
                            child: Column(
                              children: [
                                PhoneFormField(
                                  decoration: InputDecoration(
                                      hintText: "Telefon Numarası"),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(13),
                                  ],
                                  controller: phoneController,
                                  validator: (phoneNumber) {
                                    if (phoneNumber!.nsn.length == 10) {
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                ),
                                Spacer(),
                                MateButon(
                                    color:
                                        phoneController.value!.nsn.length == 10
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .dialogBackgroundColor,
                                    textcolor:
                                        Theme.of(context).primaryColorLight,
                                    title: "Devam Et",
                                    minimumSize: Size.fromHeight(50),
                                    onPressed: () {
                                      registerPage = 1;
                                      setState(() {});
                                    }),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 400.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Hoşgeldiniz ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: 'Alperen Eymen Özcan\n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              "Sistemimizde kayıtlı ${phoneController.value!.nsn} numaralı telefonunuz ile üyeliğinizi tamamlayabilirsiniz."),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .dialogBackgroundColor,
                                      width: 0.5,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: CupertinoButton(
                                    onPressed: () => {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Doğum Tarihi*",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600],
                                            )),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.grey[600],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: "Şifre*"),
                                  controller: passController,
                                ),
                                const Spacer(),
                                const Text(
                                  "Ne Kadar Süredir Müşterimizsiniz ?",
                                  textAlign: TextAlign.start,
                                ),
                                RadioListTile(
                                    title: Text("1 seneden az"),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .dialogBackgroundColor),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    value: false,
                                    groupValue: _isRadioSelected,
                                    onChanged: (test) {}),
                                const Spacer(),
                                RadioListTile(
                                    title: Text("1-3 sene"),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .dialogBackgroundColor),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    value: false,
                                    groupValue: _isRadioSelected,
                                    onChanged: (test) {}),
                                const Spacer(),
                                RadioListTile(
                                    title: Text("3 seneden fazla"),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .dialogBackgroundColor),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    value: false,
                                    groupValue: _isRadioSelected,
                                    onChanged: (test) {}),
                                Spacer(),
                                MateButon(
                                    color:
                                        phoneController.value!.nsn.length == 10
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .dialogBackgroundColor,
                                    textcolor:
                                        Theme.of(context).primaryColorLight,
                                    title: "Üye Ol",
                                    minimumSize: Size.fromHeight(50),
                                    onPressed: () {
                                      registerPage = 1;
                                      setState(() {});
                                    }),
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
