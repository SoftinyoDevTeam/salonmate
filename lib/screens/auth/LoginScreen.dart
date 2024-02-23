// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pinput/pinput.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/usermodel.dart';

import 'package:salonmate/screens/main/ScreenBridge.dart';

import 'package:salonmate/widgets/buttons.dart';

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
  PhoneController phoneController =
      PhoneController(PhoneNumber(isoCode: IsoCode.TR, nsn: ""));

  TextEditingController passController = TextEditingController();
  TextEditingController affCode = TextEditingController();
  String phoneNumber = "";
  String phoneNumberRegister = "";
  String registerType = "insert";
  String fullName = "";
  String kacyildirmusteri = "";
  UserModel? userData;
  String OTPhash = "";
  DateTime? birthday;

  int selectedTab = 0;
  int registerPage = 0;

  List<bool> isSelected = <bool>[false, true, true];

  List<bool> isSelected2 = <bool>[true, false];

  FocusNode password = FocusNode();

  bool pinCodevisible = false;
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
        body: Column(
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
                      height: ScreenUtil().screenHeight / 1.5,
                      child: Column(
                        children: [
                          PhoneFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            showDialCode: true,
                            decoration: InputDecoration(
                              hintText: "Telefon Numarası",
                            ),
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(13),
                            ],
                            controller: phoneController,
                            validator: (phoneNumber) {},
                          ),
                          SizedBox(height: 15.h),
                          Visibility(
                            visible: pinCodevisible,
                            child: Pinput(
                              closeKeyboardWhenCompleted: true,
                              length: 6,
                              pinAnimationType: PinAnimationType.slide,
                              onCompleted: (value) {
                                login(phoneNumber, value, OTPhash, context);
                              },
                            ),
                          ),
                          Spacer(),
                          MateButon(
                              color: Theme.of(context).primaryColor,
                              textcolor: Theme.of(context).primaryColorLight,
                              title: "Giriş Yap",
                              minimumSize: Size.fromHeight(50),
                              onPressed: () async {
                                phoneNumber = phoneController.value!.nsn;
                                if (pinCodevisible == false) {
                                  var response = await sendSms(phoneNumber);
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
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          height: ScreenUtil().screenHeight / 1.5,
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
                                  phoneNumberRegister = phoneNumber!.nsn;
                                },
                              ),
                              Spacer(),
                              MateButon(
                                  color: phoneController.value!.nsn.length == 10
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).dialogBackgroundColor,
                                  textcolor:
                                      Theme.of(context).primaryColorLight,
                                  title: "Devam Et",
                                  minimumSize: Size.fromHeight(50),
                                  onPressed: () async {
                                    log(phoneNumberRegister);
                                    userData = await checkRegister(
                                        phoneNumberRegister);
                                    if (userData == null) {
                                      registerType = "insert";
                                    } else {
                                      registerType = "update";
                                    }
                                    registerPage = 1;
                                    setState(() {});
                                  }),
                            ],
                          ),
                        ),
                      )
                    : registerType == "insert"
                        ? Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: SingleChildScrollView(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: Container(
                                height: 450.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("Ad Soyad"),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                            onChanged: (value) {
                                              fullName = value;
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Adınızı ve Soyadınızı Yazınız"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .dialogBackgroundColor,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: CupertinoButton(
                                        onPressed: () => {
                                          DatePickerBdaya.showDatePicker(
                                              context,
                                              showTitleActions: true,
                                              minTime: DateTime(1930, 1, 1),
                                              maxTime: DateTime(2023, 1, 1),
                                              onChanged: (date) {
                                            birthday = date;
                                            setState(() {});
                                          }, onConfirm: (date) {
                                            birthday = date;
                                            setState(() {});
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.tr)
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                birthday == null
                                                    ? "Doğum Tarihi*"
                                                    : DateFormat.yMMMMd()
                                                        .format(birthday!),
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
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Daha önce bizden hizmet aldınız mı ?"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: ScreenUtil().screenWidth / 2 -
                                              20.w,
                                          height: 45.h,
                                          child: RadioListTile(
                                              title: Text("Evet"),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Theme.of(context)
                                                          .dialogBackgroundColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              value: isSelected2[0],
                                              groupValue: _isRadioSelected,
                                              onChanged: (test) {
                                                isSelected2 = <bool>[
                                                  true,
                                                  true,
                                                  true
                                                ];

                                                isSelected2[0] =
                                                    test == true ? false : true;
                                                setState(() {});
                                              }),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: ScreenUtil().screenWidth / 2 -
                                              20.w,
                                          child: RadioListTile(
                                              title: Text("Hayır"),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Theme.of(context)
                                                          .dialogBackgroundColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              value: isSelected2[1],
                                              groupValue: _isRadioSelected,
                                              onChanged: (test) {
                                                isSelected2 = <bool>[
                                                  true,
                                                  true,
                                                  true
                                                ];
                                                isSelected2[1] =
                                                    test == true ? false : true;
                                                setState(() {});
                                              }),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: isSelected2[1],
                                      child: Container(
                                        height: 180.h,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                    "Ne Kadar Süredir Müşterimizsiniz ?",
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            RadioListTile(
                                                title: Text("1 seneden az"),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Theme.of(context)
                                                            .dialogBackgroundColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                value: isSelected[0],
                                                groupValue: _isRadioSelected,
                                                onChanged: (test) {
                                                  isSelected = <bool>[
                                                    true,
                                                    true,
                                                    true
                                                  ];

                                                  isSelected[0] = test == true
                                                      ? false
                                                      : true;
                                                  setState(() {});
                                                }),
                                            Spacer(),
                                            RadioListTile(
                                                title: Text("1-3 sene"),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: isSelected[1]
                                                            ? Theme.of(context)
                                                                .dialogBackgroundColor
                                                            : Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                value: isSelected[1],
                                                groupValue: _isRadioSelected,
                                                onChanged: (test) {
                                                  isSelected = <bool>[
                                                    true,
                                                    true,
                                                    true
                                                  ];
                                                  isSelected[1] = test == true
                                                      ? false
                                                      : true;
                                                  setState(() {});
                                                }),
                                            Spacer(),
                                            RadioListTile(
                                                title: Text("3 seneden fazla"),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Theme.of(context)
                                                            .dialogBackgroundColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                value: isSelected[2],
                                                groupValue: _isRadioSelected,
                                                onChanged: (test) {
                                                  isSelected = <bool>[
                                                    true,
                                                    true,
                                                    true
                                                  ];

                                                  isSelected[2] = test == true
                                                      ? false
                                                      : true;

                                                  setState(() {});
                                                }),
                                            Spacer()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: isSelected2[0],
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Davet kodunuz var mı ?"),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                                controller: affCode,
                                                onChanged: (value) {},
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Davet Kodu (Kodunuz yoksa boş bırakın)"))
                                          ],
                                        )),
                                    Spacer(),
                                    MateButon(
                                        color:
                                            phoneController.value!.nsn.length ==
                                                    10
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .dialogBackgroundColor,
                                        textcolor:
                                            Theme.of(context).primaryColorLight,
                                        title: "Üye Ol",
                                        minimumSize: Size.fromHeight(50),
                                        onPressed: () async {
                                          registerPage = 1;
                                          final formData = FormData.fromMap({
                                            "phone": phoneController.value!.nsn,
                                            "birthday": birthday,
                                            "fullName": fullName,
                                            "type": registerType,
                                            "phoneCode": phoneController
                                                .value!.countryCode,
                                            "affCode": affCode.text,
                                            "kacyildirmusteri":
                                                kacyildirmusteri == ""
                                                    ? "0"
                                                    : kacyildirmusteri,
                                          });
                                          log(formData.fields.toString());
                                          var response =
                                              await register(formData, context);
                                          if (response == "true") {
                                            selectedTab = 0;
                                          }
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: SingleChildScrollView(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: Container(
                                height: 450.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Hoşgeldiniz ',
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(fontSize: 10.sp),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '${userData!.adSoyad}\n',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              style: TextStyle(fontSize: 10.sp),
                                              text:
                                                  "Sistemimizde kayıtlı ${userData!.telefonKodu}${userData!.telefonNumarasi} numaralı telefonunuz ile üyeliğinizi tamamlayabilirsiniz."),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .dialogBackgroundColor,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: CupertinoButton(
                                        onPressed: () => {
                                          DatePickerBdaya.showDatePicker(
                                              context,
                                              showTitleActions: true,
                                              minTime: DateTime(1930, 1, 1),
                                              maxTime: DateTime(2023, 1, 1),
                                              onChanged: (date) {
                                            birthday = date;
                                            setState(() {});
                                          }, onConfirm: (date) {
                                            birthday = date;
                                            setState(() {});
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.tr)
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                birthday == null
                                                    ? "Doğum Tarihi*"
                                                    : DateFormat.yMMMMd()
                                                        .format(birthday!),
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
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Visibility(
                                      visible: isSelected2[1],
                                      child: Container(
                                        height: 180.h,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                    "Ne Kadar Süredir Müşterimizsiniz ?",
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            RadioListTile(
                                                title: Text("1 seneden az"),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Theme.of(context)
                                                            .dialogBackgroundColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                value: isSelected[0],
                                                groupValue: _isRadioSelected,
                                                onChanged: (test) {
                                                  isSelected = <bool>[
                                                    true,
                                                    true,
                                                    true
                                                  ];

                                                  isSelected[0] = test == true
                                                      ? false
                                                      : true;
                                                  setState(() {});
                                                }),
                                            Spacer(),
                                            RadioListTile(
                                                title: Text("1-3 sene"),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: isSelected[1]
                                                            ? Theme.of(context)
                                                                .dialogBackgroundColor
                                                            : Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                value: isSelected[1],
                                                groupValue: _isRadioSelected,
                                                onChanged: (test) {
                                                  isSelected = <bool>[
                                                    true,
                                                    true,
                                                    true
                                                  ];
                                                  isSelected[1] = test == true
                                                      ? false
                                                      : true;
                                                  setState(() {});
                                                }),
                                            Spacer(),
                                            RadioListTile(
                                                title: Text("3 seneden fazla"),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Theme.of(context)
                                                            .dialogBackgroundColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                value: isSelected[2],
                                                groupValue: _isRadioSelected,
                                                onChanged: (test) {
                                                  isSelected = <bool>[
                                                    true,
                                                    true,
                                                    true
                                                  ];

                                                  isSelected[2] = test == true
                                                      ? false
                                                      : true;

                                                  setState(() {});
                                                }),
                                            Spacer()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: isSelected2[0],
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Davet kodunuz var mı ?"),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                                controller: affCode,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Davet Kodu (Kodunuz yoksa boş bırakın)"))
                                          ],
                                        )),
                                    Spacer(),
                                    MateButon(
                                        color:
                                            phoneController.value!.nsn.length ==
                                                    10
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .dialogBackgroundColor,
                                        textcolor:
                                            Theme.of(context).primaryColorLight,
                                        title: "Üye Ol",
                                        minimumSize: Size.fromHeight(50),
                                        onPressed: () async {
                                          registerPage = 1;
                                          final formData = FormData.fromMap({
                                            "phone": phoneNumber,
                                            "birthday": birthday,
                                            "fullName": fullName,
                                            "type": registerType,
                                            "phoneCode": phoneController
                                                .value!.countryCode,
                                            "affCode": affCode.text,
                                            "kacyildirmusteri":
                                                kacyildirmusteri,
                                          });

                                          var response =
                                              await register(formData, context);
                                          if (response == "true") {
                                            selectedTab = 0;
                                          }

                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          )
          ],
        ),
      ),
    );
  }
}
