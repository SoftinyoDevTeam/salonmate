// Flutter & Dart paketleri
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Core ek paketler

import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/langs/codegen_loader.g.dart';
import 'package:salonmate/core/notifications.dart';

// Pub get paketler
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Ekran Paketleri
import 'package:salonmate/screens/auth/SalonSecScreen.dart';
import 'package:salonmate/screens/auth/SplashScreen.dart';
import 'package:salonmate/screens/errorPages/NoInternetScreen.dart';
import 'package:salonmate/screens/errorPages/OldVersionScreen.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';

SharedPreferences? prefs;
FirebaseMessaging messaging = FirebaseMessaging.instance;
String deviceType = "phone";

void main() async {
  bool internet = true;
  bool oldversion = false;
  bool salonmateMode = false;
  // Flutter initialize ediliyor
  WidgetsFlutterBinding.ensureInitialized();
  // Easy localization yükleniyor
  await EasyLocalization.ensureInitialized();
  // Salonmate sunucularından salon configi çekiliyor

  if (mateKey == "mate") {
    salonmateMode = true;
  } else {}

  // Firebase
  await Firebase.initializeApp();

  FocusManager.instance.primaryFocus?.unfocus();
  await setup();
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;

    showLocalNotification(notification!.title!, notification.body!);
  });

  prefs = await SharedPreferences.getInstance();

  setPrefString("tooltip", "true");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(EasyLocalization(
      supportedLocales: supportedLocalesdef,
      path: localizationDir,
      assetLoader: const CodegenLoader(),
      fallbackLocale: defaultLocale,
      useOnlyLangCode: true,
      child: ScreenUtilInit(
        designSize: screenDesignSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          double screenWidth = ScreenUtil().screenWidth;
          if (screenWidth > 600) {
            deviceType = "tablet";
          }
          if (internet == true) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MateServices())
              ],
              builder: (context, childs) {
                if (salonmateMode == false)
                  Provider.of<MateServices>(context, listen: false)
                      .changeThemeData();
                return MaterialApp(
                  supportedLocales: _.supportedLocales,
                  localizationsDelegates: _.localizationDelegates,
                  locale: _.locale,
                  debugShowCheckedModeBanner: false,
                  title: appname,
                  themeMode: ThemeMode.light,
                  theme: Provider.of<MateServices>(context).themeData,
                  home: child,
                );
              },
              child: child,
            );
          } else {
            return NoInternetScreen();
          }
        },
        child: oldversion
            ? OldVersionScreen()
            : await checkLogin()
                ? const ScreenBridge(
                    selectedScreen: 0,
                  )
                : salonmateMode
                    ? const SalonSecScreen()
                    : const SplashScreen(),
      )));
}
