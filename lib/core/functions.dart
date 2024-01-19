import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/models/salonconfigmodel.dart';

void post(String endpoint, Object? data) async {
  final dio = Dio();
  Response response;
  response = await dio.post(apiUrl + endpoint, data: data);
  print(response.data.toString());
}

Future<SalonConfigModel?> getSalonConfig() async {
  SalonConfigModel? config;
  try {
    Response response = await Dio().post(
      apiUrl + "api.php",
      options: Options(
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work

          "Matekey": mateKey,
        },
      ),
    );
    log('getSalonConfig: [RESPONSE] ${response.data}');
    if (response.data["status"] == "success") {
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
