


import 'segments_model.dart';
import 'summary_model.dart';

class PropertiesModel {
  PropertiesModel({
      this.segments, 
      this.summary, 
      this.wayPoints,});

  PropertiesModel.fromJson(dynamic json) {
    if (json['segments'] != null) {
      segments = [];
      json['segments'].forEach((v) {
        segments?.add(SegmentsModel.fromJson(v));
      });
    }
    summary = json['summary'] != null ? SummaryModel.fromJson(json['summary']) : null;
    wayPoints = json['way_points'] != null ? json['way_points'].cast<int>() : [];
  }
  List<SegmentsModel>? segments;
  SummaryModel? summary;
  List<int>? wayPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (segments != null) {
      map['segments'] = segments?.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      map['summary'] = summary?.toJson();
    }
    map['way_points'] = wayPoints;
    return map;
  }

}