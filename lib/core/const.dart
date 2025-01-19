import 'dart:io';
import 'package:flutter/material.dart';

// General const

const appname = 'SALONMATE';
const affCodePrefix = 'MATE';
const currency = "TL";
String platform = Platform.isAndroid ? "android" : "ios";

String mateKey = "mate"; // mate -- yadasalon token

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

// API AND 3rdParty const

const apiUrl = 'https://salonmate.co/inc/api.php';
const socketUrl = 'wss://sock.salonmate.co/';

// Dynamic app configuration in functions.dart

String buildNumber = "212";
