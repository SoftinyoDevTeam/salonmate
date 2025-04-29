// Flutter & Dart paketleri
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Core ek paketler
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/langs/codegen_loader.g.dart';
import 'package:salonmate/core/notifications.dart';
import 'package:salonmate/core/app_tracking_transparency.dart';
import 'package:salonmate/core/update_service.dart';

// Pub get paketler
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:salonmate/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_checker/store_checker.dart';
import 'package:store_checker/store_checker.dart';

// Ekran Paketleri
import 'package:salonmate/screens/auth/SalonSecScreen.dart';
import 'package:salonmate/screens/auth/SplashScreen.dart';
import 'package:salonmate/screens/errorPages/NoInternetScreen.dart';
import 'package:salonmate/screens/errorPages/OldVersionScreen.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:salonmate/screens/errorPages/UpdateRequiredScreen.dart';

SharedPreferences? prefs;
FirebaseMessaging messaging = FirebaseMessaging.instance;
String deviceType = "phone";
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver analyticsObserver =
    FirebaseAnalyticsObserver(analytics: analytics);

void main() async {
  bool internet = true;
  bool oldversion = false;
  bool salonmateMode = false;
  bool temainitialized = false;
  // Flutter initialize ediliyor
  WidgetsFlutterBinding.ensureInitialized();
  // Easy localization yükleniyor
  await EasyLocalization.ensureInitialized();
  // Salonmate sunucularından salon configi çekiliyor

  if (mateKey == "mate") {
    salonmateMode = true;
  } else {}

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable analytics data collection
  await analytics.setAnalyticsCollectionEnabled(true);

  // Log app open event
  await analytics.logAppOpen();

  await MobileAds.instance.initialize();

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
  //prefs!.clear();
  setPrefString("tooltip", "true");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Request tracking permission on iOS
  await AppTrackingService.requestTrackingPermission();

  // Check if update is required

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
          double screenWidth = ScreenUtil().screenWidth;

          if (internet == true) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MateServices())
              ],
              builder: (context, childs) {
                if (salonmateMode == false) {
                  if (temainitialized == false) {
                    Provider.of<MateServices>(context, listen: false)
                        .changeThemeData();
                    temainitialized = true;
                  }
                }
                return MaterialApp(
                  supportedLocales: _.supportedLocales,
                  localizationsDelegates: _.localizationDelegates,
                  locale: _.locale,
                  debugShowCheckedModeBanner: false,
                  debugShowMaterialGrid: false,
                  title: appname,
                  themeMode: ThemeMode.light,
                  theme: Provider.of<MateServices>(context).themeData,
                  navigatorObservers: [analyticsObserver],
                  home: child,
                );
              },
              child: child,
            );
          } else {
            return NoInternetScreen();
          }
        },
        child: !await UpdateService.checkForUpdates()
            ? UpdateRequiredScreen()
            : await checkLogin()
                ? ScreenBridge(
                    selectedScreen: 0,
                  )
                : salonmateMode
                    ? SalonSecScreen()
                    : SplashScreen(),
      )));
}
