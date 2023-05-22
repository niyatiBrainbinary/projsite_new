// To parse this JSON data, do
//
//     final companyListModel = companyListModelFromJson(jsonString);

import 'dart:convert';

CompanyListModel companyListModelFromJson(String str) => CompanyListModel.fromJson(json.decode(str));

String companyListModelToJson(CompanyListModel data) => json.encode(data.toJson());

class CompanyListModel {
  CompanyListModel({
    this.success,
    this.companyList,
  });

  bool? success;
  List<CompanyList>? companyList;

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
    success: json["success"] == null ? null : json["success"],
    companyList: json["company_list"] == null ? null : List<CompanyList>.from(json["company_list"].map((x) => CompanyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "company_list": companyList == null ? null : List<dynamic>.from(companyList!.map((x) => x.toJson())),
  };
}

class CompanyList {
  CompanyList({
    this.id,
    this.companyName,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.isDeleted,
  });

  String? id;
  String? companyName;
  OrganizationId? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool? isDeleted;

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["_id"] == null ? null : json["_id"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    organizationId: json["organization_id"] == null ? null : organizationIdValues.map[json["organization_id"]],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "company_name": companyName == null ? null : companyName,
    "organization_id": organizationId == null ? null : organizationIdValues.reverse[organizationId],
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "is_deleted": isDeleted == null ? null : isDeleted,
  };
}

enum OrganizationId { THE_5_FFEB87_C4_FDAB911_F579_A042 }

final organizationIdValues = EnumValues({
  "5ffeb87c4fdab911f579a042": OrganizationId.THE_5_FFEB87_C4_FDAB911_F579_A042
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
