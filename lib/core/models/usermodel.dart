class UserModel {
  int id;
  String adSoyad;
  String telefonNumarasi;
  DateTime dogumTarihi;
  DateTime kayitTarihi;
  String kacYillikMusteri;
  int salonId;
  String telefonKodu;
  String affKodu;
  String token;

  UserModel({
    required this.id,
    required this.adSoyad,
    required this.telefonNumarasi,
    required this.dogumTarihi,
    required this.kayitTarihi,
    required this.kacYillikMusteri,
    required this.salonId,
    required this.telefonKodu,
    required this.affKodu,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['ID'],
      adSoyad: json['fullName'],
      telefonNumarasi: json['phone'],
      dogumTarihi: DateTime.parse(json['birthday']),
      kayitTarihi: DateTime.parse(json['registerDate']),
      kacYillikMusteri:
          json['kacyildirmusteri'] == null ? "0" : json['kacyildirmusteri'],
      salonId: json['salonID'],
      telefonKodu: json['phoneCode'],
      affKodu: json['affCode'] == null ? "0" : json["affCode"],
      token: json['token'] == null ? "0" : json["token"],
    );
  }
}
