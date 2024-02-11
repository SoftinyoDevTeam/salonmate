import 'dart:convert';

class SalonConfigModel {
  String? status;
  String? message;
  Data? data;

  SalonConfigModel({this.status, this.message, this.data});

  SalonConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? iD;
  String? salonName;
  String? salonAppName;
  SalonConfig? salonConfig;
  String? createdDate;
  String? lastActivityTime;
  String? matetoken;

  Data(
      {this.iD,
      this.salonName,
      this.salonAppName,
      this.salonConfig,
      this.createdDate,
      this.lastActivityTime,
      this.matetoken});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    salonName = json['salon_name'];
    salonAppName = json['salon_app_name'];
    salonConfig = json['salon_mobile_config'] != null
        ? new SalonConfig.fromJson(jsonDecode(json["salon_mobile_config"]))
        : null;
    createdDate = json['createdDate'];
    lastActivityTime = json['lastActivityTime'];
    matetoken = json['matetoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['salon_name'] = this.salonName;
    data['salon_app_name'] = this.salonAppName;
    if (this.salonConfig != null) {
      data['salon_mobile_config'] = this.salonConfig!.toJson();
    }
    data['createdDate'] = this.createdDate;
    data['lastActivityTime'] = this.lastActivityTime;
    data['matetoken'] = this.matetoken;
    return data;
  }
}

class SalonConfig {
  String? fontFamily;
  String? primaryColor;
  String? primaryColorDark;
  String? primaryColorLight;
  String? backgroundColor;
  String? livechat;
  String? textColor;
  String? buttonColor;
  SalonConfig(
      {this.fontFamily,
      this.primaryColor,
      this.primaryColorDark,
      this.primaryColorLight,
      this.backgroundColor,
      this.livechat,
      this.textColor,
      this.buttonColor});

  SalonConfig.fromJson(Map<String, dynamic> json) {
    fontFamily = json['fontFamily'];
    primaryColor = json['primaryColor'];
    primaryColorDark = json['primaryColorDark'];
    primaryColorLight = json['primaryColorLight'];
    backgroundColor = json['backgroundColor'];
    livechat = json['livechat'];
    textColor = json['textColor'];
    buttonColor = json['buttonColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fontFamily'] = this.fontFamily;
    data['primaryColor'] = this.primaryColor;
    data['primaryColorDark'] = this.primaryColorDark;
    data['primaryColorLight'] = this.primaryColorLight;
    data['backgroundColor'] = this.backgroundColor;
    data['livechat'] = this.livechat;
    data['textColor'] = this.textColor;
    data['buttonColor'] = this.buttonColor;
    return data;
  }
}
