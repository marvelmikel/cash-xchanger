class QueryModel {
  QueryModel({
    this.coordinates,
    this.profile,
    this.format,
  });

  QueryModel.fromJson(dynamic json) {
    //  coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    if (json['coordinates'] != null) {
      coordinates = <List<double>>[];
      coordinates = json['coordinates'].forEach((v) => coordinates!.add(v));
    }
    profile = json['profile'];
    format = json['format'];
  }
  List<List<double>>? coordinates;
  String? profile;
  String? format;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['profile'] = profile;
    map['format'] = format;
    return map;
  }
}
