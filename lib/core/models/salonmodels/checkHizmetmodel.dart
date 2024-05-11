class HizmetKategoriModel {
  int? ID;
  String? name;
  int? rate;
  String? imageURL;
  List<HizmetModel>? list;

  HizmetKategoriModel({this.ID, this.name, this.rate, this.list});

  HizmetKategoriModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    name = json['name'];
    imageURL = json['imageURL'];
    rate = json['rate'];
    list = json['list'] != null
        ? List<HizmetModel>.from(
            json["list"].map((x) => HizmetModel.fromJson(x)))
        : null;
  }
}

class HizmetModel {
  int? ID;
  String? totalPrice;
  String? name;
  double? prePaymentMinRate;
  int? serviceDuration;
  String? ney;
  int? cuzdanID;

  HizmetModel(
      {this.ID,
      this.totalPrice,
      this.name,
      this.prePaymentMinRate,
      this.serviceDuration,
      this.ney,
      this.cuzdanID});

  HizmetModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    totalPrice = json['totalPrice'];
    name = json['name'];
    prePaymentMinRate = double.parse(json['prePaymentMinRate']);
    serviceDuration = json['serviceDuration'];
    ney = json['ney'] == null ? "" : json['ney'];
    cuzdanID = json["cuzdanID"] == null || json["cuzdanID"] == 0
        ? 0
        : json["cuzdanID"];
  }
}
