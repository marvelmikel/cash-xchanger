class UserMutations {
  static const String getTransactionCharges = r'''
mutation MyMutation($amount: Float = 0) {
  UserCollection {
    getFee(amount: $amount) {
      amount
      fee
      total
    }
  }
}
''';

  static const String addDebitCard = r'''
mutation MyMutation($amount: Float = 1.5, $isDefault: Boolean = false) {
  CardCollection {
    initiate(amount: $amount, isDefault: $isDefault) {
      accessCode
      reference
      url
    }
  }
}
''';

  static const String makeOrder = r'''
mutation MyMutation($amount: Float = 1.5, $lat: Float = 1.5, $long: Float = 1.5) {
  UserCollection {
    order(data: {amount: $amount, long: $long, lat: $lat})
  }
}
''';

  static const String setCashAtHand = r'''
mutation MyMutation($amount: Float = 100000.0) {
  UserCollection {
    setAvaliableCashByVendor(amount: $amount) {
      avaliableCash
      Id
      totalDepensedCashed
      signature
      selfie
      role
      phoneNumber
      kycSelfie
      kycReceipt
      kycDocument
      jobId
      isVendor
      isKycVerified
      isPhoneNumberVerified
      isEmailVerified
      isDeleted
      isActive
      generatedJobId
      fullName
      email
      city
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
