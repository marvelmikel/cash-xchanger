class NearByVendors {
  List<NearestVendors>? nearestVendors;

  NearByVendors({this.nearestVendors});

  NearByVendors.fromJson(Map<String, dynamic> json) {
    if (json['nearestVendors'] != null) {
      nearestVendors = <NearestVendors>[];
      json['nearestVendors'].forEach((v) {
        nearestVendors!.add(NearestVendors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nearestVendors != null) {
      data['nearestVendors'] =
          nearestVendors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearestVendors {
  List<double>? location;
  Vendor? vendor;

  NearestVendors({this.location, this.vendor});

  NearestVendors.fromJson(Map<String, dynamic> json) {
    location = json['location'].cast<double>();
    vendor =
    json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    return data;
  }
}

class Vendor {
  String? id;
  String? selfie;
  String? phoneNumber;
  String? fullName;
  String? email;
  String? kycSelfie;

  Vendor(
      {this.id,
        this.selfie,
        this.phoneNumber,
        this.fullName,
        this.email,
        this.kycSelfie});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    selfie = json['selfie'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    email = json['email'];
    kycSelfie = json['kycSelfie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['selfie'] = selfie;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['email'] = email;
    data['kycSelfie'] = kycSelfie;
    return data;
  }
}
