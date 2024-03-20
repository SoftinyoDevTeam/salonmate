class CuzdanimModel {
  int? point;

  CuzdanimModel({this.point});

  CuzdanimModel.fromJson(Map<String, dynamic> json) {
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point'] = this.point;
    return data;
  }
}
