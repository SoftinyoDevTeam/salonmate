import 'dart:developer';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/models/salonconfigmodel.dart';

Future<SalonConfigModel?> getSalonConfig() async {
  SalonConfigModel? config;
  try {
    Response response = await Dio().post(
      apiUrl,
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
