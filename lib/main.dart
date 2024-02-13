//Flutter dart paketleri
import 'package:flutter/material.dart';

// Core ek paketler
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/langs/codegen_loader.g.dart';
import 'package:salonmate/core/models/salonconfigmodel.dart';
import 'package:salonmate/screens/HomeScreen.dart';
import 'package:salonmate/screens/SplashScreen.dart';

//Ekranlar

SalonConfigModel? salonConfig;
void main() async {
  bool? internet = true;
  // Flutter initialize ediliyor
  WidgetsFlutterBinding.ensureInitialized();
  // Easy localization yükleniyor
  await EasyLocalization.ensureInitialized();
  // Salonmate sunucularından salon configi çekiliyor
  salonConfig = await getSalonConfig();
  // Internet bağlantısı kontrol ediliyor

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
          return MaterialApp(
            supportedLocales: _.supportedLocales,
            localizationsDelegates: _.localizationDelegates,
            locale: _.locale,
            debugShowCheckedModeBanner: false,
            title: appname,
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    EdgeInsets.only(left: 10.0, top: 10.0, bottom: 15.0),
                hintStyle: TextStyle(color: "#616165".toColor()),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: "#E0E0E4".toColor(),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: "#E0E0E4".toColor(),
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                    gapPadding: 4,
                    borderRadius: BorderRadius.circular(15.sp),
                    borderSide: BorderSide(color: Colors.red, width: 5)),
              ),
              dialogBackgroundColor: "E0E0E4".toColor(),
              useMaterial3: true,
              fontFamily: salonConfig!.data!.salonConfig!.fontFamily,
              primaryColor:
                  salonConfig!.data!.salonConfig!.primaryColor!.toColor(),
              primaryColorLight:
                  salonConfig!.data!.salonConfig!.primaryColorLight!.toColor(),
              primaryColorDark:
                  salonConfig!.data!.salonConfig!.primaryColorDark!.toColor(),
              colorScheme: ColorScheme(
                  background: salonConfig!.data!.salonConfig!.backgroundColor!
                      .toColor(),
                  brightness: Brightness.light,
                  primary:
                      salonConfig!.data!.salonConfig!.primaryColor!.toColor(),
                  onPrimary: salonConfig!.data!.salonConfig!.primaryColorDark!
                      .toColor(),
                  secondary:
                      salonConfig!.data!.salonConfig!.buttonColor!.toColor(),
                  onSecondary: salonConfig!.data!.salonConfig!.primaryColorDark!
                      .toColor(),
                  error: salonConfig!.data!.salonConfig!.primaryColorDark!
                      .toColor(),
                  onError: salonConfig!.data!.salonConfig!.primaryColorDark!
                      .toColor(),
                  onBackground: salonConfig!
                      .data!.salonConfig!.primaryColorDark!
                      .toColor(),
                  surface: salonConfig!.data!.salonConfig!.primaryColorDark!
                      .toColor(),
                  onSurface: salonConfig!.data!.salonConfig!.primaryColorDark!
                      .toColor()),
            ),
            home: child,
          );
        } else {
          return const MaterialApp(
            home: Center(child: Text("internet bağlantısı yok")),
          );
        }
      },
      child: const SplashScreen(),
    ),
  ));
}
