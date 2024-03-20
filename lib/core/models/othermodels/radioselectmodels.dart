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
      ID: json['ID'],
      fullName: json['fullName'],
      imageUrl: json['imageUrl'],
    );
  }
}
