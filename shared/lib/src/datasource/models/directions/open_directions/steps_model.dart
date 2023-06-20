class StepsModel {
  StepsModel({
      this.distance, 
      this.duration, 
      this.type, 
      this.instruction, 
      this.name, 
      this.wayPoints,});

  StepsModel.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
    type = json['type'];
    instruction = json['instruction'];
    name = json['name'];
    wayPoints = json['way_points'] != null ? json['way_points'].cast<int>() : [];
  }
  double? distance;
  double? duration;
  int? type;
  String? instruction;
  String? name;
  List<int>? wayPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    map['type'] = type;
    map['instruction'] = instruction;
    map['name'] = name;
    map['way_points'] = wayPoints;
    return map;
  }

}