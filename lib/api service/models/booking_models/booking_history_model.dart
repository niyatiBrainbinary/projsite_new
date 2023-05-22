
class BookingHistoryModel {
  BookingHistoryModel({
    this.id,
    this.event,
    this.responsiblePerson,
    this.requestId,
    this.updatedAt,
    this.createdAt,
    this.responsiblePersonName,
  });

  String? id;
  String? event;
  String? responsiblePerson;
  String? requestId;
  String? updatedAt;
  String? createdAt;
  String? responsiblePersonName;

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) => BookingHistoryModel(
    id: json["_id"],
    event: json["event"],
    responsiblePerson: json["responsible_person"],
    requestId: json["request_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    responsiblePersonName: json["responsible_person_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "event": event,
    "responsible_person": responsiblePerson,
    "request_id": requestId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "responsible_person_name": responsiblePersonName,
  };
}
