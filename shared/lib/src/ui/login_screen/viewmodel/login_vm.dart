import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/datasource/auth/auth_datasource.dart';

import '../models/login_model.dart';

final loginVM = ChangeNotifierProvider((ref) => LoginVM(ref));

class LoginVM extends ChangeNotifier {
  final Ref _ref;
  LoginVM(this._ref);
  final TempStorage prefs = TempStorage.instance;
  void login(
      {required LoginModel payload, required BuildContext context}) async {
    try {
      showLoaderDialog(context);
      final caller = await _ref.read(authService).loginUser(
            payload,
          );
      caller.fold((l) {
        _ref.read(navProvider).pop();
        alert(description: l.first.message);
      }, (r) {
        _ref.read(navProvider).pop();
        final res = Response.fromJson(r).authCollection!.userLogin;
        prefs.saveAuthToken(authToken: res!.token!);
        final user = res.user;
        _ref.read(profileViewModelProviderV1).setUserMode = user!;
        print("this is the user ${user.toJson()}");
        if (user.isVendor == false) {
          print("It passed with role ${user.role}");
        return  _ref
              .read(navProvider)
              .navigateTo(Routes.userDashBoard);
        } else if (user.isKycVerified!) {
         return _ref.read(navProvider).navigateTo( Routes.vendorDashboard);
        } else {
         return _ref.read(navProvider).navigateTo(Routes.vendorKycScreen);
        }
      });
    } catch (err) {
      _ref.read(navProvider).pop();
    }
    // emit(LoginState());
  }
}
