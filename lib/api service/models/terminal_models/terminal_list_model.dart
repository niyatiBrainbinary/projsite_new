class TerminalListModel {
  TerminalListModel({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.placeId,
  });

  dynamic? id;
  dynamic? name;
  dynamic? address;
  dynamic? latitude;
  dynamic? longitude;
  dynamic? placeId;

  factory TerminalListModel.fromJson(Map<dynamic, dynamic> json) => TerminalListModel(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    placeId: json["place_id"] == null ? null : json["place_id"],
  );

  Map<dynamic, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "place_id": placeId == null ? null : placeId,
  };
}