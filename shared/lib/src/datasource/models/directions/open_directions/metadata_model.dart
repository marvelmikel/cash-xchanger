


import 'query_model.dart';

class MetadataModel {
  MetadataModel({
      this.attribution, 
      this.service, 
      this.timestamp, 
      this.query,});

  MetadataModel.fromJson(dynamic json) {
    attribution = json['attribution'];
    service = json['service'];
    timestamp = json['timestamp'];
    query = json['query'] != null ? QueryModel?.fromJson(json['query']) : null;
  }
  String? attribution;
  String? service;
  int? timestamp;
  QueryModel? query;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribution'] = attribution;
    map['service'] = service;
    map['timestamp'] = timestamp;
    if (query != null) {
      map['query'] = query?.toJson();
    }
    return map;
  }

}