import 'dart:convert';

class SalonConfigModel {
  String? status;
  String? message;
  Data? data;

  SalonConfigModel({this.status, this.message, this.data});

  SalonConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
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
  String? salonCreatedDate;
  int? salonType;
  int? salonLocation;
  String? salonToken;
  String? salonSubdomain;
  String? appStoreLink;
  String? playStoreLink;
  int? debugMode;
  SalonConfig? salonConfig;
  PluginsConfig? pluginsConfig;

  Data({
    this.iD,
    this.salonName,
    this.salonAppName,
    this.salonCreatedDate,
    this.salonType,
    this.salonLocation,
    this.salonToken,
    this.salonSubdomain,
    this.appStoreLink,
    this.playStoreLink,
    this.debugMode,
    this.salonConfig,
    this.pluginsConfig,
  });

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    salonName = json['salon_name'];
    salonAppName = json['salon_app_name'];
    salonCreatedDate = json['salon_createdDate'];
    salonType = json['salon_type'];
    salonLocation = json['salon_location'];
    salonToken = json['salonToken'];
    salonSubdomain = json['salonsubdomain'];
    appStoreLink = json['appStoreLink'];
    playStoreLink = json['playStoreLink'];
    debugMode = json['debugMode'];
    salonConfig = json['salon_mobile_config'] != null
        ? SalonConfig.fromJson(jsonDecode(json['salon_mobile_config']))
        : null;
    pluginsConfig = json['pluginsConfig'] != null
        ? PluginsConfig.fromJson(jsonDecode(json['pluginsConfig']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = iD;
    data['salon_name'] = salonName;
    data['salon_app_name'] = salonAppName;
    data['salon_createdDate'] = salonCreatedDate;
    data['salon_type'] = salonType;
    data['salon_location'] = salonLocation;
    data['salonToken'] = salonToken;
    data['salonsubdomain'] = salonSubdomain;
    data['appStoreLink'] = appStoreLink;
    data['playStoreLink'] = playStoreLink;
    data['debugMode'] = debugMode;
    if (salonConfig != null) {
      data['salon_mobile_config'] = jsonEncode(salonConfig!.toJson());
    }
    if (pluginsConfig != null) {
      data['pluginsConfig'] = jsonEncode(pluginsConfig!.toJson());
    }
    return data;
  }
}

class SalonConfig {
  String? fontFamily;
  String? primaryColor;
  String? primaryColorDark;
  String? primaryColorLight;
  String? backgroundColor;
  String? textColor;
  String? buttonColor;
  String? livechat;
  String? urunkampanyatext;
  String? affOran;
  String? bizimhesapefaturafirmaID;
  String? minimumsepet;
  double? kargoucreti;
  String? welcomeBonus;
  String? sallakazanbgurl;
  String? popupurl; // New field for popup image
  String? popup_title; // New field for popup title
  String? popup_description; // New field for popup description

  SalonConfig({
    this.fontFamily,
    this.primaryColor,
    this.primaryColorDark,
    this.primaryColorLight,
    this.backgroundColor,
    this.textColor,
    this.buttonColor,
    this.livechat,
    this.urunkampanyatext,
    this.affOran,
    this.bizimhesapefaturafirmaID,
    this.minimumsepet,
    this.kargoucreti,
    this.welcomeBonus,
    this.sallakazanbgurl,
    this.popupurl,
    this.popup_title,
    this.popup_description,
  });

  SalonConfig.fromJson(Map<String, dynamic> json) {
    fontFamily = json['fontFamily'];
    primaryColor = json['primaryColor'];
    primaryColorDark = json['primaryColorDark'];
    primaryColorLight = json['primaryColorLight'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
    buttonColor = json['buttonColor'];
    livechat = json['livechat'];
    urunkampanyatext = json['urunkampanyatext'];
    affOran = json['affOran'];
    bizimhesapefaturafirmaID = json['bizimhesapefaturafirmaID'];
    minimumsepet = json['minimumsepet'];
    kargoucreti = json['kargoucreti'] != null
        ? double.parse(json['kargoucreti'].toString())
        : null;
    welcomeBonus = json['welcomeBonus'];
    sallakazanbgurl = json['sallakazanbgurl'];
    popupurl = json['popupurl'];
    popup_title = json['popup_title'];
    popup_description = json['popup_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fontFamily'] = fontFamily;
    data['primaryColor'] = primaryColor;
    data['primaryColorDark'] = primaryColorDark;
    data['primaryColorLight'] = primaryColorLight;
    data['backgroundColor'] = backgroundColor;
    data['textColor'] = textColor;
    data['buttonColor'] = buttonColor;
    data['livechat'] = livechat;
    data['urunkampanyatext'] = urunkampanyatext;
    data['affOran'] = affOran;
    data['bizimhesapefaturafirmaID'] = bizimhesapefaturafirmaID;
    data['minimumsepet'] = minimumsepet;
    data['kargoucreti'] = kargoucreti;
    data['welcomeBonus'] = welcomeBonus;
    data['sallakazanbgurl'] = sallakazanbgurl;
    data['popupurl'] = popupurl;
    data['popup_title'] = popup_title;
    data['popup_description'] = popup_description;
    return data;
  }
}

class PluginsConfig {
  String? asdas;
  String? bizimhesapefaturafirmaID;

  PluginsConfig({
    this.asdas,
    this.bizimhesapefaturafirmaID,
  });

  PluginsConfig.fromJson(Map<String, dynamic> json) {
    asdas = json['asdas'];
    bizimhesapefaturafirmaID = json['bizimhesapefaturafirmaID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asdas'] = asdas;
    data['bizimhesapefaturafirmaID'] = bizimhesapefaturafirmaID;
    return data;
  }
}
