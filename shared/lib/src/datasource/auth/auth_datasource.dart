import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/ui/login_screen/models/login_model.dart';
import 'package:shared/src/ui/sign_up_screen/models/register_model.dart';
import 'package:shared/src/ui/sign_up_screen/models/verify_model.dart';

final authService = Provider((_) => AuthService(_));

class AuthService {
  AuthService(this.ref);
  final Ref ref;
  loginUser(LoginModel variables) async {
    final response = await GraphqlService()
        .postMutation(AuthMutations.login, variables.toJson());

    return response;
  }

  signUpUser(RegisterModel variables) async {
    final response = await GraphqlService()
        .postMutation(AuthMutations.register, variables.toJson());

    return response;
  }

  validateOtp(VerifyModel variables) async {
    print("these are the variables ${variables.toJson()}");
    final response = await GraphqlService()
        .postMutation(AuthMutations.verifyPhone, variables.toJson());
    return response;
  }

  resendOtp(VerifyModel variables) async {
    print("these are the variables ${variables.toJson()}");
    final response = await GraphqlService()
        .postMutation(AuthMutations.resendPhoneOtp, variables.toJson());
    return response;
  }

  verifyKyc(VerifyModel variables) async {
    print("these are the variables ${variables.toJson()}");
    final response = await GraphqlService()
        .postMutation(AuthMutations.resendPhoneOtp, variables.toJson());
    return response;
  }

  getUserProfile() async {
    final response = await GraphqlService().getQuery(ProfileQuery.users);
    return response;
  }

  Future toggleStatus(OnlineModel variables) async {
    print("these are the variables ${variables.toJson()}");
    return GraphqlService()
        .postMutation(AuthMutations.toggleOnlineState, variables.toJson());
  }
}
