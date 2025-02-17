enum FirebaseErrorCodeEnum {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  userTokenExpired,
  networkRequestFailed,
  invalidCredential,
  emailAlreadyInUse,
  operationNotAllowed,
  weakPassword,
}

extension Extensionname on FirebaseErrorCodeEnum {
  static Map<FirebaseErrorCodeEnum, Map<String, dynamic>> types = {
    FirebaseErrorCodeEnum.invalidEmail: {"code": 'invalid-email'},
    FirebaseErrorCodeEnum.userDisabled: {"code": 'user-disabled'},
    FirebaseErrorCodeEnum.userNotFound: {"code": 'user-not-found'},
    FirebaseErrorCodeEnum.wrongPassword: {"code": 'wrong-password'},
    FirebaseErrorCodeEnum.tooManyRequests: {"code": 'too-many-requests'},
    FirebaseErrorCodeEnum.userTokenExpired: {"code": 'user-token-expired'},
    FirebaseErrorCodeEnum.networkRequestFailed: {
      "code": 'network-request-failed',
    },
    FirebaseErrorCodeEnum.invalidCredential: {"code": 'invalid-credential'},
    FirebaseErrorCodeEnum.emailAlreadyInUse: {"code": 'email-already-in-use'},
    FirebaseErrorCodeEnum.operationNotAllowed: {
      "code": 'operation-not-allowed',
    },
    FirebaseErrorCodeEnum.weakPassword: {"code": 'weak-password'},
  };

  String get code => types[this]!["code"] as String;
}
