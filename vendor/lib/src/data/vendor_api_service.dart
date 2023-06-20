import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

import 'models/vendor_kyc_models.dart';

final vendorApiService = ChangeNotifierProvider((ref) => VendorApis(ref));

class VendorApis extends ChangeNotifier {
  final Ref ref;
  VendorApis(this.ref);

  vendorKyc({required KYCModel variables}) async {
    final response = await GraphqlService()
        .postMutation(AuthMutations.kycVerification, variables.toJson());
    return response;
  }

  setCashAtHand({required double amount}) async {
    Map<String, dynamic> variables = {"amount": amount};
    final response = await GraphqlService()
        .postMutation(UserMutations.setCashAtHand, variables);
    return response;
  }
}
