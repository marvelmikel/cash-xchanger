class ProfileQuery {
  static const String users = r'''
query MyQuery {
  UserCollection {
    user {
      Id
      city
      email
      fullName
      generatedJobId
      isActive
      isDeleted
      isEmailVerified
      isKycVerified
      isPhoneNumberVerified
      isVendor
      jobId
      kycDocument
      kycSelfie
      kycReceipt
      phoneNumber
      role
      selfie
      signature
      cards(cardType: "", page: 10, search: "", size: 10) {
        Id
        cardBin
        cardType
        countryCode
        expMonth
        expYear
        firstName
        isDefault
        last4
        lastName
      }
    }
  }
}
''';
}
