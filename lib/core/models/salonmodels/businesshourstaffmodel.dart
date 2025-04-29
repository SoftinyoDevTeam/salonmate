class BusinessHourStaffModel {
  final int id;
  final int staffID;
  final String startTime;
  final String endTime;
  final int day;

  BusinessHourStaffModel({
    required this.id,
    required this.staffID,
    required this.startTime,
    required this.endTime,
    required this.day,
  });

  factory BusinessHourStaffModel.fromMap(Map<String, dynamic> map) {
    return BusinessHourStaffModel(
      id: map["ID"] ?? '',
      staffID: map["staffID"] ?? '',
      startTime: map["startTime"] ?? '',
      endTime: map["endTime"] ?? '',
      day: map["day"] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": id,
      "staffID": staffID,
      "startTime": startTime,
      "endTime": endTime,
      "day": day,
    };
  }
}
