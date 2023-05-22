
class PendingShipmentListModel {
  PendingShipmentListModel({
    this.totalCount,
    this.data,
  });

  int? totalCount;
  List<PendingList>? data;

  factory PendingShipmentListModel.fromJson(Map<String, dynamic> json) => PendingShipmentListModel(
    totalCount: json["totalCount"],
    data: json["data"] == null ? [] : List<PendingList>.from(json["data"].map((x) => PendingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PendingList {
  PendingList({
    this.requestId,
    this.projectId,
    this.projectName,
    this.responsiblePersonFirstName,
    this.responsiblePersonLastName,
    this.from,
    this.to,
    this.unloadingZone,
    this.shipmentType,
  });

  String? requestId;
  String? projectId;
  String? projectName;
  String? responsiblePersonFirstName;
  String? responsiblePersonLastName;
  String? from;
  String? to;
  String? unloadingZone;
  String? shipmentType;

  factory PendingList.fromJson(Map<String, dynamic> json) => PendingList(
    requestId: json["requestId"],
    projectId: json["projectId"],
    projectName: json["projectName"],
    responsiblePersonFirstName: json["responsiblePersonFirstName"],
    responsiblePersonLastName: json["responsiblePersonLastName"],
    from: json["from"],
    to: json["to"],
    unloadingZone: json["unloadingZone"],
    shipmentType: json["shipmentType"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "projectId": projectId,
    "projectName": projectName,
    "responsiblePersonFirstName": responsiblePersonFirstName,
    "responsiblePersonLastName": responsiblePersonLastName,
    "from": from,
    "to": to,
    "unloadingZone": unloadingZone,
    "shipmentType": shipmentType,
  };
}