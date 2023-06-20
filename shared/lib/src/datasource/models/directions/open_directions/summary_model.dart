class SummaryModel {
  SummaryModel({
      this.distance, 
      this.duration,});

  SummaryModel.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
  }
  double? distance;
  double? duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    return map;
  }

}