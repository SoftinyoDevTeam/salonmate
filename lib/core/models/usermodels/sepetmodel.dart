class Bildirim {
  int? ID;
  String? name;
  String? imgUrl;
  DateTime? createdDate;
  int? price;

  Bildirim({
    this.ID,
    this.name,
    this.imgUrl,
    this.createdDate,
    this.price,
  });

  factory Bildirim.fromJson(Map<String, dynamic> json) {
    return Bildirim(
      ID: json['ID'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      createdDate: DateTime.parse(json['createdDate']),
      price: json['price'],
    );
  }
}
