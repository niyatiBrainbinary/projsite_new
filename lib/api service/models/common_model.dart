class CommonModel {
  CommonModel({
    this.success,
    this.result,
  });

  bool? success;
  dynamic result;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
    success: json["success"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result,
  };
}