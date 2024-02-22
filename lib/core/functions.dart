import 'dart:developer';
import 'dart:html';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/models/salonconfigmodel.dart';
import 'package:salonmate/core/models/usermodel.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setPrefString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
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
    log('getSalonConfig: [RESPONSE] ${response.data}');
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
    log(response.data.toString());
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

Future<String> login(
    String phoneNumber, String code, String hash, BuildContext context) async {
  FormData form =
      FormData.fromMap({"phone": phoneNumber, "key": code, "hash": hash});

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
    log(response.data.toString());
    if (response.data["status"] == "200") {
      UserModel user = UserModel.fromJson(response.data["data"]);
      setPrefString("token", user.token);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ScreenBridge()),
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
    log("[ checkRegister : RESPONSE ]" + response.data.toString());
    if (response.data["status"] == "200") {
      return UserModel.fromJson(response.data["data"]);
    } else {
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      log('checkRegister: [ERROR] ${response.data["message"]}');
      return null;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Uzak sunucuya erişim reddedildi. $e");
    log('checkRegister: [ERROR] $e', error: e);
    return null;
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
    log("[ register : RESPONSE ]" + response.toString());
    if (response.data["status"] == "200") {
      UserModel user = UserModel.fromJson(response.data["data"]);
      setPrefString("token", user.token);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ScreenBridge()),
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
