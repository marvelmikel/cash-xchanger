class CardAuthorization {
  CardAuthorization({
    this.accessCode,
    this.authorizationUrl,
    this.reference,
  });

  CardAuthorization.fromJson(dynamic json) {
    accessCode = json['accessCode'];
    authorizationUrl = json['url'];
    reference = json['reference'];
  }
  String? accessCode;
  String? authorizationUrl;
  String? reference;
  CardAuthorization copyWith({
    String? accessCode,
    String? authorizationUrl,
    String? reference,
  }) =>
      CardAuthorization(
        accessCode: accessCode ?? this.accessCode,
        authorizationUrl: authorizationUrl ?? this.authorizationUrl,
        reference: reference ?? this.reference,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessCode'] = accessCode;
    map['url'] = authorizationUrl;
    map['reference'] = reference;
    return map;
  }
}
