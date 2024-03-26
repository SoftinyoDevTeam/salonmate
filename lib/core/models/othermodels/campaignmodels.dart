class CampaignModel {
  int? ID;
  String? name;
  String? imageUrl;
  String? descriptions;
  int? price;
  int? serviceID;
  String? type;

  CampaignModel(
      {this.ID,
      this.name,
      this.imageUrl,
      this.descriptions,
      this.price,
      this.serviceID,
      this.type});

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
        ID: json["ID"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        descriptions: json["descriptions"],
        price: json["price"],
        serviceID: json["serviceID"],
        type: json["type"]);
  }
}
