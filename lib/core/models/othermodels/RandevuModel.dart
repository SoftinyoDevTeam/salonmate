class RandevuModel {
  int? ID;
  String? staffname;
  String? staffimg;
  String? servicename;
  DateTime? scheduleStart;
  DateTime? scheduleEnd;
  String? customerReview;
  int? star;

  RandevuModel(
      {this.ID,
      this.staffname,
      this.staffimg,
      this.servicename,
      this.scheduleStart,
      this.scheduleEnd,
      this.customerReview,
      this.star});

  factory RandevuModel.fromJson(Map<String, dynamic> json) {
    return RandevuModel(
        ID: json['randevuID'],
        servicename: json["name"],
        staffname: json["fullName"],
        staffimg: json["imageUrl"],
        scheduleStart: DateTime.parse(json["scheduleStart"]),
        scheduleEnd: DateTime.parse(json["scheduleEnd"]),
        star: json["star"],
        customerReview:
            json["customerReview"] == null ? "" : json["customerReview"]);
  }
}
