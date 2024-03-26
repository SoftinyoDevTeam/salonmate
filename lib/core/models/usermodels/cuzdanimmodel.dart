// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:salonmate/core/models/salonmodels/checkHizmetmodel.dart';

class CuzdanimModel {
  int? point;
  List<HizmetModel>? hizmetler;

  CuzdanimModel({this.point, this.hizmetler});

  CuzdanimModel.fromJson(Map<String, dynamic> json) {
    point = json['point'];
    hizmetler = (json['hizmetlist'] != null
        ? List<HizmetModel>.from(
            json["hizmetlist"].map((x) => HizmetModel.fromJson(x)))
        : null)!;
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point'] = this.point;
    data["hizmetlist"] = this.hizmetler;
    return data;
  }
}
