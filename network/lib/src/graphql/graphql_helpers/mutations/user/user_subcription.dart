class UserSubscription {
  static const String getVendorsNearMe = r'''
subscription MySubscription {
  nearestVendors {
    location
    vendor {
      Id
      selfie
      phoneNumber
      fullName
      email
      kycSelfie

    }
  }
}
''';
}
