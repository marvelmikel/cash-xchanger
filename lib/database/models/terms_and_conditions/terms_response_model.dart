import 'terms_model.dart';

class TermsResponseModel {
  TermsResponseModel({
    this.termsModel,
    this.message,
    this.status,
  });

  TermsResponseModel.fromJson(dynamic json) {
    termsModel =
        json['data'] != null ? TermsModel.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
  TermsModel? termsModel;
  String? message;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (termsModel != null) {
      map['data'] = termsModel!.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}
