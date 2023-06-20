import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/login_screen/models/login_model.dart';
import 'auth/auth_datasource.dart';

final sharedRepo = ChangeNotifierProvider((ref) => SharedRepo(ref));

class SharedRepo extends ChangeNotifier {
  Ref _ref;
  SharedRepo(this._ref);

  loginWithEmailAndPassword({required LoginModel payload,required  BuildContext context}) async {
    final response =
        await _ref.read(authService).loginUser(payload);


  }
}
