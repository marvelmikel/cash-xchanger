


import 'steps_model.dart';

class SegmentsModel {
  SegmentsModel({
      this.distance, 
      this.duration, 
      this.steps,});

  SegmentsModel.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
    if (json['steps'] != null) {
      steps = [];
      json['steps'].forEach((v) {
        steps?.add(StepsModel.fromJson(v));
      });
    }
  }
  double? distance;
  double? duration;
  List<StepsModel>? steps;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    if (steps != null) {
      map['steps'] = steps?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}