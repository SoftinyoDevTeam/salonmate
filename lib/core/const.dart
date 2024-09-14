import 'dart:io';
import 'package:flutter/material.dart';

// General const

const appname = 'SALONMATE';
const affCodePrefix = 'MATE';
const currency = "TL";
String platform = Platform.isAndroid ? "android" : "ios";
String mateKey = "bahars-s0e6-44c5-ac17-a9bcd947ff0c";

// Localization const

const defaultLocale = Locale('en');
const supportedLocalesdef = [Locale('tr'), Locale('en')];
const localizationDir = 'assets/translations';

// Responsibility and sizes const

const screenDesignSize = Size(360, 690);

// API AND 3rdParty const

const apiUrl = 'https://salonmate.co/inc/api.php';
const socketUrl = 'wss://sock.salonmate.co/';

// Dynamic app configuration in functions.dart

