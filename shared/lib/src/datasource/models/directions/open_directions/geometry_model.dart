class GeometryModel {
  GeometryModel({
    this.coordinates,
    this.type,
  });

  GeometryModel.fromJson(dynamic json) {
    // if (json['coordinates'] != null) {
    //   bbox = json['bbox'] != null ? json['bbox'].cast<double>() : [];
    //   coordinates = <List<double>>[];
    coordinates = json['coordinates'] != null
        ? json['coordinates'].cast<List<dynamic>>()
        : [];
    //  coordinates = json['coordinates'].forEach((v) => coordinates!.add(v));
    //  }
    type = json['type'];
  }
  List<List<dynamic>>? coordinates;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }
}
