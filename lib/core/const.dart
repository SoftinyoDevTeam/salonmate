import 'dart:io';
import 'package:flutter/material.dart';

// General const

const appname = 'SALONMATE';
const currency = "TL";
String platform = Platform.isAndroid ? "android" : "ios";
String mateKey = "a690ecb2-e0c6-44c5-ac17-d8fcf947ff0c";

// Localization const

const defaultLocale = Locale('en');
const supportedLocalesdef = [Locale('tr'), Locale('en')];
const localizationDir = 'assets/translations';

// Responsibility and sizes const

const screenDesignSize = Size(360, 690);

// API AND 3rdParty const

const apiUrl = 'https://salonmate.co/inc/api.php';

// Dynamic app configuration in functions.dart

