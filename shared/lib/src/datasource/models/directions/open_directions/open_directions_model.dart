import 'features_model.dart';
import 'metadata_model.dart';

class OpenDirections {
  OpenDirections({
    this.type,
    this.features,
    this.bbox,
   
  });

  OpenDirections.fromJson(dynamic json) {
    type = json['type'];
    features = FeaturesModel.fromJson(json['features'][0]);

    bbox = json['bbox'] != null ? json['bbox'].cast<double>() : [];
  }
  String? type;
  FeaturesModel? features;
  List<double>? bbox;
  MetadataModel? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;

    map['features'] = features;
    return map;
  }
}
