import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ios_keyboard_action/ios_keyboard_action.dart';
import 'package:salonmate/core/libs/phone_form_field//phone_form_field.dart';
import 'package:pinput/pinput.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/usermodels/usermodel.dart';
import 'package:salonmate/main.dart';
import 'package:salonmate/screens/auth/SozlesmeScreen.dart';
import 'package:salonmate/widgets/auth/registerPin.dart';
import 'package:salonmate/widgets/buttons.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key, required this.fcmToken});
  final String fcmToken;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final registerphonenumberfocusnode = FocusNode();
  final nextFieldFocus = FocusNode();
  final previousFieldFocus = FocusNode();
  final doneFieldFocus = FocusNode();
  bool isChecked = false;
  UserModel? user;
  String registerType = "insert";
  PhoneController phoneController =
      PhoneController(initialValue: PhoneNumber(isoCode: IsoCode.TR, nsn: ""));
  String? birthday = "";
  bool? yesno;
  double _currentSliderValue = 1;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController affCode = TextEditingController();
  TextEditingController birthfield = TextEditingController();
  int kacyildirmusteri = 0;

  @override
  void dispose() {
    registerphonenumberfocusnode.dispose();
    nextFieldFocus.dispose();
    previousFieldFocus.dispose();
    doneFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            user != null
                ? SizedBox(
                    height: 50.h,
                    child: Text.rich(TextSpan(children: <InlineSpan>[
                      TextSpan(text: ("general.welcome").tr() + " "),
                      TextSpan(
                        text: user!.adSoyad,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      TextSpan(
                        text: ",\n" + user!.telefonNumarasi!,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      TextSpan(
                          text:
                              " numaralı telefonunuzla sistemimize üye oluyorsunuz."),
                    ])))
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                  height: 60.h,
                  width: ScreenUtil().screenWidth - 30,
                  child: PhoneFormField(
                    autofocus: true,
                    focusNode: registerphonenumberfocusnode,
                    isCountrySelectionEnabled: true,
                    isCountryButtonPersistent: true,
                    countrySelectorNavigator:
                        CountrySelectorNavigator.draggableBottomSheet(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      hintText: ("general.phone").tr(),
                    ),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(13),
                    ],
                    controller: phoneController,
                    onChanged: (value) async {
                      if (value!.isValidLength(type: PhoneNumberType.mobile)) {
                        user =
                            await checkRegister(value!.nsn.replaceAll(" ", ""));
                        if (user != null) {
                          registerType = "update";
                          var oldname = user!.adSoyad.split(" ");
                          firstname.text = (oldname.first);
                          lastname.text = (oldname.last);
                        } else {
                          registerType = "insert";
                          firstname.text = "";
                          lastname.text = "";
                        }
                        setState(() {});
                      }
                    },
                    validator: PhoneValidator.compose([
                      PhoneValidator.validMobile(context,
                          errorText:
                              ("general.errors.wrong_phone_number").tr()),
                      PhoneValidator.required(context,
                          errorText:
                              ("general.errors.required_phone_number").tr())
                    ]),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 40.h,
                      width: deviceType == "phone"
                          ? (ScreenUtil().screenWidth - 46.sp) / 2
                          : (ScreenUtil().screenWidth - 126.sp) / 2,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: firstname,
                        focusNode: nextFieldFocus,
                        decoration:
                            InputDecoration(hintText: ("general.fname").tr()),
                      )),
                  SizedBox(
                      height: 40.h,
                      width: deviceType == "phone"
                          ? (ScreenUtil().screenWidth - 46.sp) / 2
                          : (ScreenUtil().screenWidth - 126.sp) / 2,
                      child: TextFormField(
                        focusNode: doneFieldFocus,
                        textCapitalization: TextCapitalization.words,
                        controller: lastname,
                        decoration:
                            InputDecoration(hintText: ("general.lname").tr()),
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () async {
                    showCupDialog(
                        Material(
                          child: Container(
                            color: Colors.white,
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Tamam",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  CupertinoColors.activeBlue),
                                        )),
                                  )
                                ],
                              ),
                              Flexible(
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now()
                                      .subtract(Duration(days: 5000)),
                                  mode: CupertinoDatePickerMode.date,
                                  use24hFormat: true,
                                  showDayOfWeek: false,
                                  onDateTimeChanged: (DateTime newDate) {
                                    birthday =
                                        DateFormat("yyyy-MM-d").format(newDate);
                                    setState(() {});
                                    log(birthday.toString());
                                    birthfield.text = DateFormat("d MMMM yyyy")
                                        .format(newDate);
                                  },
                                ),
                              )
                            ]),
                          ),
                        ),
                        context,
                        false);
                  },
                  child: TextFormField(
                    enabled: false,
                    controller: birthfield,
                    decoration:
                        InputDecoration(hintText: ("general.birthday").tr()),
                  ),
                )),
            user == null
                ? Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            ("RegisterWidget.didyouservicefromus").tr(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50.h,
                              width: deviceType == "phone"
                                  ? (ScreenUtil().screenWidth - 50.sp) / 2
                                  : (ScreenUtil().screenWidth - 116.sp) / 2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (yesno == null ? false : yesno!)
                                      ? Colors.green
                                      : Color.fromARGB(255, 224, 224, 228),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CheckboxListTile(
                                side: BorderSide(
                                    width: 1.0,
                                    color: Color.fromARGB(255, 224, 224, 228)),
                                checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                title: Text(("general.yes").tr()),
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                value: yesno == null ? false : yesno!,
                                onChanged: (bool? value) {
                                  yesno = true;
                                  setState(() {});
                                },
                              ),
                            ),
                            Container(
                              height: 50.h,
                              width: deviceType == "phone"
                                  ? (ScreenUtil().screenWidth - 50.sp) / 2
                                  : (ScreenUtil().screenWidth - 116.sp) / 2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: (yesno == null ? false : !yesno!)
                                        ? Colors.green
                                        : Color.fromARGB(255, 224, 224, 228)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CheckboxListTile(
                                side: BorderSide(
                                    width: 1.0,
                                    color: Color.fromARGB(255, 224, 224, 228)),
                                checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                title: Text(("general.no").tr()),
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                value: yesno == null ? false : !yesno!,
                                onChanged: (bool? value) {
                                  yesno = false;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        yesno != null
                            ? yesno!
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Text(
                                            "Ne kadar süredir müşterimizsiniz ?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 60.h,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "1 Yıldan Az",
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary),
                                                  ),
                                                  Text(
                                                    "1-3 Yıl Arası",
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary),
                                                  ),
                                                  Text(
                                                    "3 Yıldan Fazla",
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary),
                                                  ),
                                                ],
                                              ),
                                              Slider(
                                                inactiveColor: Theme.of(context)
                                                    .dialogBackgroundColor,
                                                secondaryActiveColor:
                                                    Theme.of(context)
                                                        .primaryColorLight,
                                                thumbColor: Theme.of(context)
                                                    .primaryColorLight,
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                value: _currentSliderValue,
                                                max: 2,
                                                divisions: 2,
                                                onChanged: (double value) {
                                                  setState(() {
                                                    kacyildirmusteri =
                                                        value.toInt();
                                                    _currentSliderValue = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Text(
                                            ("RegisterWidget.affiliate_code")
                                                .tr(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            height: 40.h,
                                            child: TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.characters,
                                              controller: affCode,
                                              decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorDark
                                                          .withOpacity(0.7),
                                                      fontSize: 14.sp),
                                                  hintText:
                                                      ("RegisterWidget.affiliate_code_enter")
                                                          .tr()),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                            : Container(),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            ("RegisterWidget.howlongcustomeryouare").tr(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                          child: Slider(
                            inactiveColor:
                                Theme.of(context).dialogBackgroundColor,
                            secondaryActiveColor:
                                Theme.of(context).primaryColorLight,
                            thumbColor: Theme.of(context).primaryColorLight,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            value: _currentSliderValue,
                            max: 2,
                            divisions: 2,
                            label: _currentSliderValue.round() <= 0
                                ? ("RegisterWidget.lessthan1year").tr()
                                : _currentSliderValue.round() >= 2
                                    ? ("RegisterWidget.morethan3year").tr()
                                    : ("RegisterWidget.13year").tr(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: true,
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                  snap: true,
                                  expand: false,
                                  builder: (context, scrollController) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: Container(
                                          height:
                                              ScreenUtil().screenHeight / 1.1,
                                          child: SozlesmeScreen()),
                                    );
                                  });
                            });
                      },
                      child: Text(("RegisterWidget.agreement_confirm").tr()),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: MateButon(
                  title: ("general.register").tr(),
                  minimumSize: Size(400.w, 40.h),
                  onPressed: () async {
                    final formData = FormData.fromMap({
                      "phone": phoneController.value!.nsn,
                      "birthday": birthday,
                      "fullName": firstname.text + " " + lastname.text,
                      "type": registerType,
                      "phoneCode": phoneController.value!.countryCode,
                      "affCode": affCode.text,
                      "kacyildirmusteri":
                          kacyildirmusteri == null ? 0 : kacyildirmusteri!,
                      "fcmToken": widget.fcmToken
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPinPage(formData: formData)));
                    //var response = await register(formData, context);
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Theme.of(context).primaryColorLight),
            )
          ],
        ),
      ),
    );
  }
}
