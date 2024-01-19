//Flutter dart paketleri
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

// Core ek paketler
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/langs/codegen_loader.g.dart';
import 'package:salonmate/core/models/salonconfigmodel.dart';

//Ekranlar
import 'package:salonmate/screens/HomeScreen.dart';
import 'package:salonmate/screens/SplashScreen.dart';

void main() async {
  // Flutter initialize ediliyor
  WidgetsFlutterBinding.ensureInitialized();
  // Easy localization yükleniyor
  await EasyLocalization.ensureInitialized();
  // Salonmate sunucularından salon configi çekiliyor
  SalonConfigModel? salonConfig = await getSalonConfig();

  runApp(EasyLocalization(
    supportedLocales: supportedLocalesdef,
    path: localizationDir,
    assetLoader: CodegenLoader(),
    fallbackLocale: defaultLocale,
    useOnlyLangCode: true,
    child: ScreenUtilInit(
      designSize: screenDesignSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          supportedLocales: _.supportedLocales,
          localizationsDelegates: _.localizationDelegates,
          locale: _.locale,
          debugShowCheckedModeBanner: false,
          title: AppName,
          theme: ThemeData(
            textTheme: TextTheme(
              displayLarge:
                  TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              bodySmall: TextStyle(
                  fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
                  fontSize: 12.sp,
                  color: salonConfig!.data!.salonConfig!.primaryColorLight!
                      .toColor()),
              bodyMedium: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
                  color: salonConfig!.data!.salonConfig!.primaryColorLight!
                      .toColor()),
              bodyLarge: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
                  color: salonConfig!.data!.salonConfig!.primaryColorLight!
                      .toColor()),
              headlineSmall: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
                  color: salonConfig!.data!.salonConfig!.primaryColorLight!
                      .toColor()),
              headlineMedium: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
                  color: salonConfig!.data!.salonConfig!.primaryColorLight!
                      .toColor()),
              headlineLarge: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
                  color: salonConfig!.data!.salonConfig!.primaryColorLight!
                      .toColor()),
            ),
            useMaterial3: true,
            fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
            primaryColor:
                salonConfig!.data!.salonConfig!.primaryColor!.toColor(),
            primaryColorLight:
                salonConfig!.data!.salonConfig!.primaryColorLight!.toColor(),
            primaryColorDark:
                salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
            colorScheme: ColorScheme(
                background:
                    salonConfig!.data!.salonConfig!.backgroundColor!.toColor(),
                brightness: Brightness.dark,
                primary:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                onPrimary:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                secondary:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                onSecondary:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                error:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                onError:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                onBackground:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                surface:
                    salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
                onSurface: salonConfig!.data!.salonConfig!.primaryColorDark!
                    .toColor()),
          ),
          home: child,
        );
      },
      child: SplashScreen(),
    ),
  ));
}
