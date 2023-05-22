/*

class AddBookingModel {
  AddBookingModel({
    this.requestId,
    this.event,
    this.responsiblePerson,
    this.success,
    this.msg,
    this.response,
  });

  String? requestId;
  String? event;
  String? responsiblePerson;
  bool? success;
  String? msg;
  Response? response;

  factory AddBookingModel.fromJson(Map<String, dynamic> json) => AddBookingModel(
    requestId: json["request_id"],
    event: json["event"],
    responsiblePerson: json["responsible_person"],
    success: json["success"],
    msg: json["msg"],
    response: json["response"],
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "event": event,
    "responsible_person": responsiblePerson,
    "success": success,
    "msg": msg,
    "response": response,
  };
}

class Response {
  Response({
    this.requestId,
    this.event,
    this.responsiblePerson,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? requestId;
  String? event;
  String? responsiblePerson;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? id;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    requestId: json["request_id"],
    event: json["event"],
    responsiblePerson: json["responsible_person"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "event": event,
    "responsible_person": responsiblePerson,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "_id": id,
  };
}
*/

// To parse this JSON data, do
//
//     final addBookingModel = addBookingModelFromJson(jsonString);

import 'dart:convert';


class AddBookingModel {
  AddBookingModel({
    this.requestId,
    this.event,
    this.responsiblePerson,
    this.success,
    this.msg,
    this.response,
  });

  String? requestId;
  String? event;
  String? responsiblePerson;
  bool? success;
  String? msg;
  Response? response;

  factory AddBookingModel.fromJson(Map<String, dynamic> json) => AddBookingModel(
    requestId: json["request_id"],
    event: json["event"],
    responsiblePerson: json["responsible_person"],
    success: json["success"],
    msg: json["msg"],
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "event": event,
    "responsible_person": responsiblePerson,
    "success": success,
    "msg": msg,
    "response": response!.toJson(),
  };
}

class Response {
  Response({
    this.requestId,
    this.event,
    this.responsiblePerson,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? requestId;
  String? event;
  String? responsiblePerson;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? id;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    requestId: json["request_id"],
    event: json["event"],
    responsiblePerson: json["responsible_person"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "event": event,
    "responsible_person": responsiblePerson,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "_id": id,
  };
}

