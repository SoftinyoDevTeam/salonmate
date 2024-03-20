class Bildirim {
  int? id;
  String? title;
  String? description;
  DateTime? createdDate;
  int? salonID;

  Bildirim({
    this.id,
    this.title,
    this.description,
    this.createdDate,
    this.salonID,
  });

  factory Bildirim.fromJson(Map<String, dynamic> json) {
    return Bildirim(
      id: json['ID'],
      title: json['title'],
      description: json['description'],
      createdDate: DateTime.parse(json['createdDate']),
      salonID: json['salonID'],
    );
  }
}
