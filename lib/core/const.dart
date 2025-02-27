import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:salonmate/core/functions.dart';

// General const

const appname = "Bahar Babacan";
const affCodePrefix = 'MATE';
const currency = "TL";
String platform = Platform.isAndroid ? "android" : "ios";

String mateKey =
    "bahars-s0e6-44c5-ac17-a9bcd947ff0c"; // mate -- yadasalon token

// Localization const

const defaultLocale = Locale('tr');
const supportedLocalesdef = [
  Locale('tr'),
  Locale('en'),
  Locale('et'),
  Locale('ru')
];
const localizationDir = 'assets/translations';

// Responsibility and sizes const

const screenDesignSize = Size(360, 690);
final defaultPinThemetablet = PinTheme(
  width: 44.w,
  height: 44.w,
  textStyle: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(20),
  ),
);

// API AND 3rdParty const

const apiUrl = 'https://salonmate.co/inc/api.php';
const socketUrl = 'wss://sock.salonmate.co/';

// Dynamic app configuration in functions.dart

String buildNumber = "212";
