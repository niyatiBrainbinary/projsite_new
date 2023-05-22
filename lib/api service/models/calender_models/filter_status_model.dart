
class FilterStatusModel {
  FilterStatusModel({
    this.success,
    this.data,
  });

  bool? success;
  StatusData? data;

  factory FilterStatusModel.fromJson(Map<String, dynamic> json) => FilterStatusModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : StatusData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data,
  };
}

class StatusData {
  StatusData({
    this.approved,
    this.pending,
    this.rejected,
    this.notArrived,
    this.inProgress,
    this.unloaded,
    this.checkpointArrived,
  });

  String? approved;
  String? pending;
  String? rejected;
  String? notArrived;
  String? inProgress;
  String? unloaded;
  String? checkpointArrived;

  factory StatusData.fromJson(Map<String, dynamic> json) => StatusData(
    approved: json["approved"] == null ? null : json["approved"],
    pending: json["pending"] == null ? null : json["pending"],
    rejected: json["rejected"] == null ? null : json["rejected"],
    notArrived: json["not_arrived"] == null ? null : json["not_arrived"],
    inProgress: json["in_progress"] == null ? null : json["in_progress"],
    unloaded: json["unloaded"] == null ? null : json["unloaded"],
    checkpointArrived: json["checkpoint_arrived"] == null ? null : json["checkpoint_arrived"],
  );

  Map<String, dynamic> toJson() => {
    "approved": approved == null ? null : approved,
    "pending": pending == null ? null : pending,
    "rejected": rejected == null ? null : rejected,
    "not_arrived": notArrived == null ? null : notArrived,
    "in_progress": inProgress == null ? null : inProgress,
    "unloaded": unloaded == null ? null : unloaded,
    "checkpoint_arrived": checkpointArrived == null ? null : checkpointArrived,
  };
}
