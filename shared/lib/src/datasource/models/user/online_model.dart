class OnlineModel {
  bool? isVendor;
  bool? isOnline;
  double? lat;
  double? long;

  OnlineModel({this.isVendor, this.isOnline, this.lat, this.long});

  OnlineModel.fromJson(Map<String, dynamic> json) {
    isVendor = json['isVendor'];
    isOnline = json['isOnline'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isVendor'] = isVendor;
    data['isOnline'] = isOnline;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
