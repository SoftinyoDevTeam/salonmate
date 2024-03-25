class SepetModel {
  int? ID;
  String? imgUrl;
  String? title;
  double? price;

  SepetModel({this.ID, this.imgUrl, this.title, this.price});

  factory SepetModel.fromJson(Map<String, dynamic> json) {
    return SepetModel(
        ID: json['ID'],
        imgUrl: json['imgUrl'],
        title: json["name"],
        price: double.tryParse(json["price"]));
  }
}
