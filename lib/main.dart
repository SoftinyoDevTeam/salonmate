//Flutter dart paketleri
import 'dart:io';
import 'dart:developer';

import 'package:dart_eval/dart_eval.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// Core ek paketler
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/langs/codegen_loader.g.dart';
import 'package:salonmate/core/models/othermodels/sepetmodel.dart';
import 'package:salonmate/core/models/salonconfigmodel.dart';
import 'package:salonmate/core/notifications.dart';
import 'package:salonmate/screens/auth/SplashScreen.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Ekranlar
SalonConfigModel? salonConfig;
SharedPreferences? prefs;

void main() async {
  bool? internet = true;
  // Flutter initialize ediliyor
  WidgetsFlutterBinding.ensureInitialized();
  // Easy localization yükleniyor
  await EasyLocalization.ensureInitialized();
  // Salonmate sunucularından salon configi çekiliyor
  salonConfig = await getSalonConfig();
  // Firebase
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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
          if (internet == true) {
            return GestureDetector(
              onTap: () {},
              child: MaterialApp(
                supportedLocales: _.supportedLocales,
                localizationsDelegates: _.localizationDelegates,
                locale: _.locale,
                debugShowCheckedModeBanner: false,
                title: appname,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                  ),
                  radioTheme: RadioThemeData(fillColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Colors.green;
                  })),
                  inputDecorationTheme: InputDecorationTheme(
                    constraints:
                        BoxConstraints(minHeight: 45.h, maxHeight: 45.h),
                    contentPadding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 15.0),
                    hintStyle: TextStyle(
                      color: "E0E0E4".toColor(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: "#E0E0E4".toColor(), width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: "#E0E0E4".toColor(),
                        width: 0.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                        gapPadding: 4,
                        borderRadius: BorderRadius.circular(15.sp),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 0.5)),
                  ),
                  dialogBackgroundColor: "E0E0E4".toColor(),
                  useMaterial3: true,
                  fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
                  primaryColor:
                      salonConfig!.data!.salonConfig!.primaryColor!.toColor(),
                  primaryColorLight: salonConfig!
                      .data!.salonConfig!.primaryColorLight!
                      .toColor(),
                  primaryColorDark: salonConfig!
                      .data!.salonConfig!.primaryColorDark!
                      .toColor(),
                  colorScheme: ColorScheme(
                    outline: "#F5F5F9".toColor(),
                    background: salonConfig!.data!.salonConfig!.backgroundColor!
                        .toColor(),
                    brightness: Brightness.light,
                    primary:
                        salonConfig!.data!.salonConfig!.primaryColor!.toColor(),
                    onPrimary: salonConfig!.data!.salonConfig!.primaryColorDark!
                        .toColor(),
                    secondary: "#272E54".toColor(),
                    onSecondary: "#C5C5D4".toColor(),
                    error: salonConfig!.data!.salonConfig!.primaryColorDark!
                        .toColor(),
                    onError: "#02C081".toColor(),
                    onBackground: salonConfig!
                        .data!.salonConfig!.primaryColorDark!
                        .toColor(),
                    surface: "#272E54".toColor(),
                    onSurface: "#272E54".toColor(),
                  ),
                ),
                home: child,
              ),
            );
          } else {
            return const MaterialApp(
                home: Center(child: Text("internet bağlantısı yok")));
          }
        },
        child:
            await checkLogin() ? const ScreenBridge() : const SplashScreen()),
  ));
}
