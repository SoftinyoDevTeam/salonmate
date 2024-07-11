class OrdersHistory {
  int? ID;
  String? name;
  int? rate;
  List<ProductHistoryModel>? list;

  OrdersHistory({this.ID, this.name, this.rate, this.list});

  OrdersHistory.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    name = json['name'];
    rate = json['rate'];
    list = json['list'] != null
        ? List<ProductHistoryModel>.from(
            json["list"].map((x) => ProductHistoryModel.fromJson(x)))
        : null;
  }
}

class ProductHistoryModel {
  int? ID;
  String? name;
  String? imgUrl;
  int? price;
  int? statusID;

  ProductHistoryModel(
      {required this.ID,
      required this.name,
      required this.imgUrl,
      required this.price,
      required this.statusID});
  factory ProductHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProductHistoryModel(
        ID: json['ID'],
        name: json["name"],
        imgUrl: json["imgUrl"],
        price: json["price"],
        statusID: json["orderStatus"]);
  }
}
