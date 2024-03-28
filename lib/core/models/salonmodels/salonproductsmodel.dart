class ProductCategoryModel {
  int? ID;
  String? catname;
  String? imgUrl;
  List<SalonProductsModel>? list;

  ProductCategoryModel({this.ID, this.catname, this.imgUrl, this.list});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    catname = json['catname'];
    imgUrl = json['imgUrl'];
    list = json['list'] != null
        ? List<SalonProductsModel>.from(
            json["list"].map((x) => SalonProductsModel.fromJson(x)))
        : null;
  }
}

class SalonProductsModel {
  int? ID;
  String? name;
  String? description;
  String? imgUrl;
  bool? showMobile;
  int? price;

  SalonProductsModel(
      {required this.ID,
      required this.name,
      required this.description,
      required this.imgUrl,
      required this.showMobile,
      required this.price});
  factory SalonProductsModel.fromJson(Map<String, dynamic> json) {
    return SalonProductsModel(
        ID: json['ID'],
        name: json["name"],
        description: json["aciklama"],
        imgUrl: json["imgUrl"],
        showMobile: json["showMobile"] == 1 ? true : false,
        price: json["price"] == null ? 0 : json["price"]);
  }
}
