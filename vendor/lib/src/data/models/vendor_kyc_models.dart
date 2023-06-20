class KYCModel {
  String? base64LiveImage;
  String? documentFront;
  String? idType;

  KYCModel({
    this.base64LiveImage,
    this.documentFront,
    this.idType,
  });

  KYCModel.fromJson(Map<String, dynamic> json) {
    base64LiveImage = json['base64LiveImage'];
    documentFront = json['documentFront'];
    idType = json['idType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base64LiveImage'] = base64LiveImage;
    data['documentFront'] = documentFront;
    data['idType'] = idType;

    return data;
  }
}
