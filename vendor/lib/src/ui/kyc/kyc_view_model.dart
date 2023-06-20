import 'dart:collection';

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/src/data/vendor_api_service.dart';
import 'package:vendor/src/ui/kyc/upload_doc/upload_id.dart';

import '../../data/models/vendor_kyc_models.dart';
import 'upload_doc/upload_photo_bottomsheet.dart';

final kycViewModel = ChangeNotifierProvider((ref) => VendorKYC(ref));

class VendorKYC extends ChangeNotifier {
  VendorKYC(this.ref);
  final Ref ref;
  Future<void> submitJob(
      {required String documentType,
      required BuildContext context}) async {
    try {
      showLoaderDialog(context);
      await ref.read(vendorApiService).vendorKyc(
            variables: KYCModel(
              idType: documentType,
              documentFront: base64ID.value,
              base64LiveImage: base64Image.value,
            ),
          );
      ref.read(navProvider).pop();
      ref.read(navProvider).navigateTo(Routes.vendorDashboard);
    } catch (err) {
      ref.read(navProvider).pop();
      print("this is the err $err");
    }
  }
}
