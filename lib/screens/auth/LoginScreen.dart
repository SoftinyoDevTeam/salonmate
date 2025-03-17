import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/libs/phone_form_field//phone_form_field.dart';
import 'package:pinput/pinput.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/widgets/auth/register.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/loader.dart';

class LoginScreen extends StatefulWidget {
  int tab;
  LoginScreen({
    Key? key,
    required this.tab,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? fcmToken;
  final pinputFocusNode = FocusNode();
  void getFcm() async {
    await Future.delayed(Duration(seconds: 1));
    fcmToken = await messaging.getToken();
    setState(() {});
  }

  PhoneController phoneController =
      PhoneController(initialValue: PhoneNumber(isoCode: IsoCode.TR, nsn: ""));
  FocusNode phoneFocusNode = FocusNode();
  TextEditingController passController = TextEditingController();
  TextEditingController affCode = TextEditingController();
  String phoneNumber = "";

  String fullName = "";

  String OTPhash = "";
  DateTime? birthday;

  int selectedTab = 0;
  int registerPage = 0;

  List<bool> isSelected = <bool>[false, true, true];

  List<bool> isSelected2 = <bool>[true, false];

  FocusNode password = FocusNode();

  bool pinCodevisible = false;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.tab;
    getFcm();
    setState(() {});
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    pinputFocusNode.dispose();
    passController.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                                width: deviceType == "phone"
                                    ? (ScreenUtil().screenWidth - 56.sp) / 2
                                    : (ScreenUtil().screenWidth - 156.sp) / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(14.sp, 14.sp)),
                                    color: selectedTab == 0
                                        ? Theme.of(context).primaryColorLight
                                        : Colors.transparent),
                                child: Center(
                                  child: Text(
                                    ("general.login").tr(),
                                    style: const TextStyle(color: Colors.black),
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
                                width: deviceType == "phone"
                                    ? (ScreenUtil().screenWidth - 56.sp) / 2
                                    : (ScreenUtil().screenWidth - 156.sp) / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(14.sp, 14.sp)),
                                    color: selectedTab == 1
                                        ? Theme.of(context).primaryColorLight
                                        : Colors.transparent),
                                child: Center(
                                  child: Text(
                                    ("general.register").tr(),
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
                        child: SizedBox(
                          height: ScreenUtil().screenHeight / 1.5,
                          child: Column(
                            children: [
                              Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth - 30,
                                child: PhoneFormField(
                                  focusNode: phoneFocusNode,
                                  autofocus: true,
                                  keyboardType: Platform.isIOS
                                      ? TextInputType.number
                                      : TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    hintText: ("general.phone").tr(),
                                    hintStyle: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  controller: phoneController,
                                  onChanged: (value) {
                                    if (value!.nsn.length == 10) {
                                      FocusScope.of(context).unfocus();
                                    }
                                    log(value!.nsn.length.toString());
                                  },
                                  validator: PhoneValidator.compose([
                                    PhoneValidator.validMobile(context,
                                        errorText:
                                            ("general.errors.wrong_phone_number")
                                                .tr()),
                                    PhoneValidator.required(context,
                                        errorText:
                                            ("general.errors.required_phone_number")
                                                .tr())
                                  ]),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Visibility(
                                visible: pinCodevisible,
                                child: Pinput(
                                  focusNode: pinputFocusNode,
                                  autofocus: true,
                                  closeKeyboardWhenCompleted: true,
                                  length: 6,
                                  pinAnimationType: PinAnimationType.slide,
                                  onCompleted: (value) async {
                                    await login(
                                        phoneNumber,
                                        value,
                                        OTPhash,
                                        context,
                                        fcmToken == null
                                            ? "cantfetchfcm"
                                            : fcmToken!);
                                  },
                                ),
                              ),
                              const Spacer(),
                              MateButon(
                                  color: Theme.of(context).primaryColor,
                                  textcolor:
                                      Theme.of(context).primaryColorLight,
                                  title: ("general.login").tr(),
                                  minimumSize: const Size.fromHeight(50),
                                  onPressed: () async {
                                    pinputFocusNode.requestFocus();
                                    phoneNumber = phoneController.value!.nsn;
                                    if (pinCodevisible == false) {
                                      var response = await sendSms(phoneNumber,
                                          phoneController.value!.countryCode);
                                      if (response == "false") {
                                        pinCodevisible = false;
                                      } else {
                                        pinCodevisible = true;
                                        OTPhash = response;
                                      }
                                    }

                                    setState(() {});
                                  }),
                              SizedBox(height: 18.h),
                            ],
                          ),
                        ),
                      )
                    : registerPage == 0
                        ? fcmToken != null
                            ? Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: SizedBox(
                                    height: ScreenUtil().screenHeight / 1.5,
                                    child: SizedBox(
                                        height: ScreenUtil().screenHeight / 1.5,
                                        child: RegisterWidget(
                                          fcmToken: fcmToken!,
                                        ))),
                              )
                            : Center(
                                child: Loader(),
                              )
                        : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
