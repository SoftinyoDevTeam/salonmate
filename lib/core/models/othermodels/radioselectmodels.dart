class RadioSelectModels {
  int? ID;
  String? fullName;
  String? imageUrl;

  RadioSelectModels({
    this.ID,
    this.fullName,
    this.imageUrl,
  });

  factory RadioSelectModels.fromJson(Map<String, dynamic> json) {
    return RadioSelectModels(
      ID: json['staffID'] != null
          ? json["staffID"]
          : json["ID"] == null
              ? ""
              : json["ID"],
      fullName: json['fullName'] != null
          ? json["fullName"]
          : json["name"] == null
              ? ""
              : json["name"],
      imageUrl: json['imageUrl'] != null ? json["imageUrl"] : "test",
    );
  }
}
