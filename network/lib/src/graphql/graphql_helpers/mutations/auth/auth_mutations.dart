class AuthMutations {
  static const String login = r'''
mutation MyMutation($credentials: String = "", $username: String = "") {
  AuthCollection {
    userLogin(data: {username: $username, credentials: $credentials}) {
      Id
      loginAt
      token
      userId
      user {
        Id
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
        totalDepensedCashed
        avaliableCash
        jobId
        kycDocument
        kycReceipt
        kycSelfie
        phoneNumber
        role
        selfie
        signature
      }
    }
  }
}
''';

  static const String register = r'''
mutation MyMutation($city: String = "", $credentials: String!, $email: String!, $fullName: String!, $isVendor: Boolean!, $phoneNumber: String!) {
  UserCollection {
    createUser(
      data: {email: $email, fullName: $fullName, phoneNumber: $phoneNumber, credentials: $credentials, city: $city, isVendor: $isVendor}
    )
  }
}
''';

  static const String startReset = r'''
mutation MyMutation($email: String = "") {
  UserCollection {
    sendEmailVerificationCode(email: $email)
  }
}
''';

static const String resetPassword = r'''
mutation MyMutation($password: String!, $email1: String!, $code: String!) {
  UserCollection {
    resetPassword(code: $code, email: $email1, password: $password)
  }
}
''';


static const String resendPhoneOtp = r'''
mutation MyMutation($phoneNumber: String!) {
  UserCollection {
    sendPhoneVerificationCode(phoneNumber: $phoneNumber)
  }
}
''';

static const String verifyPhone = r'''
mutation MyMutation($code: String = "", $phoneNumber: String = "") {
  UserCollection {
    verifyPhoneNumber(phoneNumber: $phoneNumber, code: $code) {
      token
      user {
        Id
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
        kycReceipt
        kycSelfie
        phoneNumber
        role
        selfie
        signature
      }
      loginAt
      Id
      userId
    }
  }
}
''';



  static const String kycVerification = r'''
mutation MyMutation($base64LiveImage: String = "", $documentFront: String = "", $idType: String = "") {
  UserCollection {
    verifyKyc(
      base64LiveImage: $base64LiveImage
      documentFront: $documentFront
      idType: $idType
    )
  }
}
''';


  static const String toggleOnlineState = r'''
mutation MyMutation($long: Float = 1.5, $lat: Float = 1.5, $isVendor: Boolean = false, $isOnline: Boolean = false) {
  UserCollection {
    setLiveStatus(
      data: {isVendor: $isVendor, isOnline: $isOnline, lat: $lat, long: $long}
    )
  }
}
''';

}
