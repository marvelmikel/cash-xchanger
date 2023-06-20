class TermsModel {
  TermsModel({
    this.section,
    this.title,
  });

  TermsModel.fromJson(dynamic json) {
    section = json['section'] != null ? json['section'].cast<String>() : [];
    title = json['title'];
  }
  List<String>? section;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['section'] = section;
    map['title'] = title;
    return map;
  }
}