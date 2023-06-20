import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/src/datasource/auth/auth_datasource.dart';

import '../../shared.dart';

final profileViewModelProviderV1 = ChangeNotifierProvider((ref) {
  return ProfileViewModel(ref);
});

class ProfileViewModel extends ChangeNotifier {
  final Ref ref;
  ProfileViewModel(this.ref);
  final TempStorage prefs = TempStorage.instance;
  User? _userModel;
  List<Banks> userBanks = <Banks>[];

  List<TransactionHistory> transactionHistory = <TransactionHistory>[];
   BankInfoModel bankInfoModel  = BankInfoModel(bankName: "bankName", bankCode: "bankCode", accountNumber: "accountNumber", accountName: "accountName");
  User get currentUser {
    if (_userModel != null) {
      return _userModel!;
    } else {
      throw 'user not logged in';
    }
  }
  // tefekap700@pyadu.com

  set setUserMode(User user) {
    _userModel = user;
    notifyListeners();
  }

  Future<bool> getUserProfile() async {
    _userModel = await ref.read(authService).getUserProfile();
    notifyListeners();
    return false;
  }
  addBank(){}
  getNigerianBanks(){}
  void resetData() {
    prefs.resetData();
    debugPrint('User logged out');
  }

  verifyAccountNumber({required String accountNumber, required String bankName, required String bankCode, required BuildContext context}) {}

  void uploadImage({required imageFile}) {}
}
