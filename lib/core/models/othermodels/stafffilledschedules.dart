class StaffFilledSchedules {
  int? ID;
  DateTime? scheduleStart;
  DateTime? scheduleEnd;

  StaffFilledSchedules({
    this.ID,
    this.scheduleStart,
    this.scheduleEnd,
  });

  factory StaffFilledSchedules.fromJson(Map<String, dynamic> json) {
    return StaffFilledSchedules(
        ID: json['ID'],
        scheduleStart: DateTime.parse(json["scheduleStart"]),
        scheduleEnd: DateTime.parse(json['scheduleEnd']));
  }
}
