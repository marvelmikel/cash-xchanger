

import 'geometry_model.dart';
import 'properties_model.dart';

class FeaturesModel {
  FeaturesModel({
      this.bbox, 
      this.type, 
      this.properties, 
      this.geometry,});

  FeaturesModel.fromJson(dynamic json) {
    bbox = json['bbox'] != null ? json['bbox'].cast<double>() : [];
    type = json['type'];
    properties = json['properties'] != null ? PropertiesModel.fromJson(json['properties']) : null;
    geometry = json['geometry'] != null ? GeometryModel.fromJson(json['geometry']) : null;
  }
  List<double>? bbox;
  String? type;
  PropertiesModel? properties;
  GeometryModel? geometry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bbox'] = bbox;
    map['type'] = type;
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    return map;
  }

}