import 'dart:developer';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/models/othermodels/RandevuModel.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/core/models/othermodels/radioselectmodels.dart';
import 'package:salonmate/core/models/othermodels/sepetmodel.dart';
import 'package:salonmate/core/models/salonmodels/checkHizmetmodel.dart';
import 'package:salonmate/core/models/salonmodels/salonproductsmodel.dart';
import 'package:salonmate/core/models/salonmodels/siparisgecmisimodel.dart';
import 'package:salonmate/core/models/usermodels/bildirimmodel.dart';
import 'package:salonmate/core/models/salonconfigmodel.dart';
import 'package:salonmate/core/models/usermodels/cuzdanimmodel.dart';
import 'package:salonmate/core/models/usermodels/usermodel.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setPrefString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> getPrefString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<bool> checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = await prefs.get("token");
  if (token != null && token != "") {
    return true;
  } else {
    return false;
  }
}

Future<SalonConfigModel?> getSalonConfig() async {
  SalonConfigModel? config;
  try {
    Response response = await Dio().post(
      apiUrl + "?module=checkSalon",
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      config = SalonConfigModel.fromJson(response.data);
      return config;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('getSalonConfig: [ERROR] ${response.data["message"]}');
      return null;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('getSalonConfig: [ERROR] $e', error: e);
    return null;
  }
}

Future<bool> checkNetwork() async {
  bool isConnected = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
    }
  } on SocketException catch (_) {
    isConnected = false;
  }
  return isConnected;
}

Future<String> sendSms(String phoneNumber) async {
  FormData form = FormData.fromMap({"phone": phoneNumber});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=login",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      return response.data["data"]["hash"];
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('sendSms: [ERROR] ${response.data["message"]}');
      return "false";
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('sendSms: [ERROR] $e', error: e);
    return "false";
  }
}

Future<String> login(String phoneNumber, String code, String hash,
    BuildContext context, String fcmToken) async {
  FormData form = FormData.fromMap(
      {"phone": phoneNumber, "key": code, "hash": hash, "fcmToken": fcmToken});

  try {
    Response response = await Dio().post(
      apiUrl + "?module=login",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      UserModel user = UserModel.fromJson(response.data["data"]);
      setPrefString("token", user.token);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => ScreenBridge(
                    selectedScreen: 0,
                  )),
          (Route<dynamic> route) => false);
      return "true";
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('login: [ERROR] ${response.data["message"]}');
      return "false";
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('login: [ERROR] $e', error: e);
    return "false";
  }
}

Future<UserModel?> checkRegister(String phoneNumber) async {
  FormData form = FormData.fromMap({"phone": phoneNumber});

  try {
    Response response = await Dio().post(
      apiUrl + "?module=checkRegister",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      return UserModel.fromJson(response.data["data"]);
    } else {
      log('checkRegister: [ERROR] ${response.data["message"]}');
      return null;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('checkRegister: [ERROR] $e', error: e);
    return null;
  }
}

Future<List<Bildirim?>> notificationlist() async {
  FormData form = FormData.fromMap({"phone": ""});
  List<Bildirim?> notifications = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=notificationList",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      for (var e in response.data["data"]) {
        notifications.add(Bildirim.fromJson(e));
      }
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('notificationlist: [ERROR] ${response.data["message"]}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('notificationlist: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<List<SepetModel?>> getCart() async {
  FormData form = FormData.fromMap({"phone": ""});
  List<SepetModel?> products = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=getCart",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      if (response.data["data"] != null) {
        for (var e in response.data["data"]) {
          products.add(SepetModel.fromJson(e));
        }
      }

      return products;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('getCart: [ERROR] ${response.data["message"]}');
      return products;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('getCart: [ERROR] $e', error: e);
    return products;
  }
}

Future<String> register(FormData form, BuildContext context) async {
  try {
    Response response = await Dio().post(
      apiUrl + "?module=register",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      UserModel user = UserModel.fromJson(response.data["data"]);
      setPrefString("token", user.token);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => ScreenBridge(
                    selectedScreen: 0,
                  )),
          (Route<dynamic> route) => false);
      return "true";
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('register: [ERROR] ${response.data}');
      return "false";
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('register: [ERROR] $e', error: e);
    return "false";
  }
}

logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<List<SalonProductsModel?>> getProducts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  FormData form = FormData.fromMap({"token": prefs.getString("token")});
  List<SalonProductsModel?> notifications = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=getProductsMobile",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      response.data["data"].forEach((element) {
        notifications.add(SalonProductsModel.fromJson(element));
      });
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('getProducts: [ERROR] ${response.data["message"]}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('getProducts: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<UserModel?> getProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  FormData form = FormData.fromMap({"token": prefs.getString("token")});
  UserModel? notifications;
  try {
    Response response = await Dio().post(
      apiUrl + "?module=getProfile",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": mateKey,
        },
      ),
    );

    if (response.data["status"] == "200") {
      notifications = UserModel.fromJson(response.data["data"]);
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('getProfile: [ERROR] ${response.data["message"]}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('getProfile: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<CuzdanimModel?> checkCuzdanim() async {
  CuzdanimModel? notifications;
  try {
    Response response = await Dio().post(
      apiUrl + "?module=checkCuzdanim",
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      notifications = CuzdanimModel.fromJson(response.data["data"]);
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('checkCuzdanim: [ERROR] ${response.data}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('checkCuzdanim: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<List<HizmetKategoriModel?>> checkHizmetler() async {
  List<HizmetKategoriModel?> notifications = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=services",
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      response.data["data"].forEach((element) {
        notifications.add(HizmetKategoriModel.fromJson(element));
      });
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('checkHizmetler: [ERROR] ${response.data}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('checkHizmetler: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<List<ProductCategoryModel?>> procat() async {
  List<ProductCategoryModel?> notifications = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=getProductsWithCategory",
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      response.data["data"].forEach((element) {
        notifications.add(ProductCategoryModel.fromJson(element));
      });
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('procat: [ERROR] ${response.data}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('procat: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<List<RadioSelectModels?>> checkRadioList(
    String module, FormData formData) async {
  List<RadioSelectModels?> elements = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=$module",
      data: formData,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      response.data["data"].forEach((element) {
        elements.add(RadioSelectModels.fromJson(element));
      });
      return elements;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('checkRadioList: [ERROR] ${response.data}');
      return elements;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('checkRadioList: [ERROR] $e', error: e);
    return elements;
  }
}

Future<List<RandevuModel?>> fetchRandevu() async {
  List<RandevuModel?> elements = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=fetchRandevu",
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      response.data["data"].forEach((element) {
        elements.add(RandevuModel.fromJson(element));
      });
      return elements;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('fetchRandevu: [ERROR] ${response.data}');
      return elements;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('fetchRandevu: [ERROR] $e', error: e);
    return elements;
  }
}

Future<List<DateTime>> checkStaffFilledSchedules(String staffID) async {
  List<DateTime> elements = [];
  FormData data = FormData.fromMap({"staffID": staffID});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=getFilledSchedules",
      data: data,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    //log("checkStaffFilledSchedules : [ RESPONSE ]" + response.data.toString());
    if (response.data["status"] == "200") {
      response.data["data"].forEach((element) {
        DateTime scheduleStart = DateTime.parse(element["scheduleStart"]);
        DateTime scheduleEnd = DateTime.parse(element["scheduleEnd"]);
        int serviceDuration = scheduleEnd.difference(scheduleStart).inMinutes;

        double parts = serviceDuration / 15;

        for (var i = 0; i < parts; i++) {
          elements.add(scheduleStart);
          scheduleStart = scheduleStart.add(Duration(minutes: 15));
        }
        elements.add(scheduleEnd);
      });
      return elements;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('checkStaffFilledSchedules: [ERROR] ${response.data}');
      return elements;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('checkStaffFilledSchedules: [ERROR] $e', error: e);
    return elements;
  }
}

Future<bool> updateMyDataMobile(String column, String value) async {
  FormData form = FormData.fromMap({"column": column, "value": value});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=updateMyDataMobile",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      return true;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('updateMyDataMobile: [ERROR] ${response.data}');
      return false;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('updateMyDataMobile: [ERROR] $e', error: e);
    return false;
  }
}

Future<bool> shakeWin() async {
  FormData form = FormData.fromMap({});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=shakeWin",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );
    if (response.data["status"] == "200") {
      Fluttertoast.showToast(
          msg: "Tebrikler ! ${response.data["data"][0]["name"]} kazandınız !");
    } else {
      if (response.data["status"] == "404") {
        Fluttertoast.showToast(
            msg: "Maalesef olmadı lütfen daha sonra tekrar dene");
      } else if (response.data["status"] == "405") {
        Fluttertoast.showToast(msg: "Günde sadece 1 kez oynayabilirsiniz. ");
      }
    }

    return true;
  } catch (e) {
    log('shakeWin: [ERROR] $e', error: e);
    return false;
  }
}

Future<bool> checkAff() async {
  FormData form = FormData.fromMap({});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=shakeWin",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );
    if (response.data["status"] == "200") {
      Fluttertoast.showToast(
          msg: "Tebrikler ! ${response.data["data"][0]["name"]} kazandınız !");
    } else {
      Fluttertoast.showToast(
          msg: "Maalesef olmadı lütfen daha sonra tekrar dene");
    }

    return true;
  } catch (e) {
    log('shakeWin: [ERROR] $e', error: e);
    return false;
  }
}

List<DateTimeRange> getEmptySchedule(
    DateTime day, TimeOfDay sTime, TimeOfDay dTime) {
  //o günün giriş çıkış saatleri
  var period = Duration(minutes: 15);
  var startDateTime =
      DateTime(day.year, day.month, day.day, sTime.hour, sTime.minute);
  var departureDateTime =
      DateTime(day.year, day.month, day.day, dTime.hour, dTime.minute);
  var dateTimeRanges = <DateTimeRange>[];
  var current = startDateTime;
  while (current.isBefore(departureDateTime)) {
    dateTimeRanges.add(DateTimeRange(start: current, end: current.add(period)));
    current = current.add(period);
  }
  return dateTimeRanges;
}

List<DateTimeRange> parseFilledShedule(List<DateTimeRange> schedule) {
  List<DateTimeRange> list = [];
  for (var i = 0; i < schedule.length; i++) {
    list.addAll(divideDateTimeRange(schedule[i]));
    list.sort((a, b) => a.start.compareTo(b.start));
  }
  return list;
}

List<DateTimeRange> divideDateTimeRange(DateTimeRange dateTimeRange) {
  var period = Duration(minutes: 15);
  List<DateTimeRange> list = [];
  //print(dateTimeRange.duration.inMinutes);
  if (dateTimeRange.duration.inMinutes > 15) {
    var start = dateTimeRange.start;
    while (start.isBefore(dateTimeRange.end)) {
      list.add(DateTimeRange(start: start, end: start.add(period)));
      start = start.add(period);
    }
    return list;
  } else {
    return list = [dateTimeRange];
  }
}

Future<bool> addRandevu(int serviceID, int staffID, DateTime start,
    int duration, int subeID) async {
  FormData form = FormData.fromMap({
    "serviceID": serviceID,
    "staffID": staffID,
    "scheduleStart": start.toString(),
    "duration": duration,
    "subeID": subeID
  });

  try {
    Response response = await Dio().post(
      apiUrl + "?module=addRandevu",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      return true;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('addRandevu: [ERROR] ${response.data}');
      return false;
    }
  } catch (e) {
    debugPrint(e.toString());
    //Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log("addRandevu: [ERROR] ${e.toString()}", error: e);
    return false;
  }
}

Future<bool> cancelService(int sID) async {
  FormData form = FormData.fromMap({"sID": sID});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=randevuCancel",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      return true;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('CANCELSERVICE: [ERROR] ${response.data}');
      return false;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('CANCELSERVICE: [ERROR] $e', error: e);
    return false;
  }
}

Future<bool> addToCart(int seyID, String ney, String customerToken) async {
  FormData form = FormData.fromMap(
      {"seyID": seyID, "ney": ney, "customerToken": customerToken});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=AddToCart",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      return true;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('AddToCart: [ERROR] ${response.data}');
      return false;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('AddToCart: [ERROR] $e', error: e);
    return false;
  }
}

Future<bool> sendReview(int scheduleID, int star, String customerReview) async {
  FormData form = FormData.fromMap({
    "scheduleID": scheduleID,
    "star": star,
    "customerReview": customerReview
  });
  try {
    Response response = await Dio().post(
      apiUrl + "?module=sendReview",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    Fluttertoast.showToast(msg: response.data["message"]);

    return true;
  } catch (e) {
    Fluttertoast.showToast(msg: "Başarıyla değerlendirmeniz alınmıştır. $e");
    log('sendReview: [ERROR] $e', error: e);
    return false;
  }
}

Future<List<CampaignModel?>> getCampaigns() async {
  FormData form = FormData.fromMap({"phone": ""});

  List<CampaignModel?> notifications = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=getCampaigns",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      for (var e in response.data["data"]) {
        notifications.add(CampaignModel.fromJson(e));
      }
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('getCampaigns: [ERROR] ${response.data["message"]}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('getCampaigns: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<bool> completeCart() async {
  FormData form = FormData.fromMap({"column": ""});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=completeCart",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      return true;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('completeCart: [ERROR] ${response.data}');
      return false;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('completeCart: [ERROR] $e', error: e);
    return false;
  }
}

Future<List<ProductHistoryModel?>> getsiparislerim() async {
  FormData form = FormData.fromMap({"phone": ""});
  List<ProductHistoryModel?> notifications = [];
  try {
    Response response = await Dio().post(
      apiUrl + "?module=getsiparislerim",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      for (var e in response.data["data"]) {
        notifications.add(ProductHistoryModel.fromJson(e));
      }
      return notifications;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('getsiparislerim: [ERROR] ${response.data["message"]}');
      return notifications;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('getsiparislerim: [ERROR] $e', error: e);
    return notifications;
  }
}

Future<bool> deleteCart(int ID) async {
  FormData form = FormData.fromMap({"itemID": ID});
  try {
    Response response = await Dio().post(
      apiUrl + "?module=deleteCart",
      data: form,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Matekey": await getPrefString("token"),
        },
      ),
    );

    if (response.data["status"] == "200") {
      return true;
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('deleteCart: [ERROR] ${response.data}');
      return false;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('deleteCart: [ERROR] $e', error: e);
    return false;
  }
}
