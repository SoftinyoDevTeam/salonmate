class ProductKategori {
  int? ID;
  String? name;
  String? imgUrl;

  ProductKategori({this.ID, this.name, this.imgUrl});

  ProductKategori.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    name = json['catname'];
    imgUrl = json['imgUrl'];
  }
}
