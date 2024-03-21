class SalonProductsModel {
  int? ID;
  String? name;
  String? imgUrl;
  bool? showMobile;
  int? price;

  SalonProductsModel(
      {required this.ID,
      required this.name,
      required this.imgUrl,
      required this.showMobile,
      required this.price});
  factory SalonProductsModel.fromJson(Map<String, dynamic> json) {
    return SalonProductsModel(
        ID: json['ID'],
        name: json["name"],
        imgUrl: json["imgUrl"],
        showMobile: json["showMobile"] == 1 ? true : false,
        price: json["price"] == null ? 0 : json["price"]);
  }
}
