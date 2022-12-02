import 'package:cash_xchanger/api_service/profile_api/profile_details_api.dart';
import 'package:cash_xchanger/api_service/transactions_api/transaction_api.dart';
import 'package:cash_xchanger/database/models/profile_model/profile_model.dart';
import 'package:cash_xchanger/database/models/vendor_rating_model/vendor_rating_model.dart';
import 'package:cash_xchanger/ui/vendor/upload_doc/upload_photo_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/models/transaction_history_and_balance_model/transaction_balance_model.dart';
import '../../database/models/transaction_history_and_balance_model/transaction_history_model.dart';
import '../../database/shared_preferences/temp_database.dart';

class ProfileState {
  ProfileModel? profileModel;
  VendorRatingsModel? vendorRatingsModel;
  TransactionBalanceModel? transactionBalanceModel;
  ProfilePic? profilePic;
  List<TransactionHistory> transactionHistory;

  bool isDatabaseEmpty;

  ProfileState(
      {required this.profilePic,
      required this.profileModel,
      required this.transactionBalanceModel,
      required this.vendorRatingsModel,
      required this.transactionHistory,
      required this.isDatabaseEmpty});
}

class ProfileCubit extends Cubit<ProfileState> {
  TempDataBaseImpl tempDataBaseImpl;
  TransactionHistoryImp transactionHistoryImp;
  ProfileDetailsImp profileDetailsImp;

  ProfileCubit(
      {required this.tempDataBaseImpl,
      required this.transactionHistoryImp,
      required this.profileDetailsImp})
      : super(ProfileState(
            transactionBalanceModel: null,
            profileModel: null,
            vendorRatingsModel: null,
            profilePic: null,
            transactionHistory: [],
            isDatabaseEmpty: true));

  void _emitCurrentState() {
    emit(ProfileState(
        profilePic: state.profilePic,
        profileModel: state.profileModel,
        vendorRatingsModel: state.vendorRatingsModel,
        transactionHistory: state.transactionHistory.reversed.toList(),
        transactionBalanceModel: state.transactionBalanceModel,
        isDatabaseEmpty: state.isDatabaseEmpty));
  }

  void resetData() {
    tempDataBaseImpl.resetData();
    emit(ProfileState(
        transactionBalanceModel: null,
        vendorRatingsModel: null,
        profileModel: null,
        profilePic: null,
        transactionHistory: [],
        isDatabaseEmpty: true));
    debugPrint('User logged out');
  }

  void uploadImage({required imageBytes, required BuildContext context}) {
    profileDetailsImp
        .uploadImage(
            imageBytes: imageBytes,
            context: context,
            email: state.profileModel!.userDetails.email)
        .then((value) {
      _emitCurrentState();
      debugPrint('Image uploaded');
    });
  }

  void changePassword(
      {required previousPassword,
      required newPassword,
      required BuildContext context}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;

    profileDetailsImp.changePassword(
        previousPassword: previousPassword,
        newPassword: newPassword,
        email: userData.email,
        context: context);
  }

  void vendorRating({required BuildContext context}) async {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    await profileDetailsImp
        .vendorRating(email: userData.email, context: context)
        .then((value) {
      var vendorRatings = tempDataBaseImpl.getVendorRating();

      emit(ProfileState(
          profilePic: state.profilePic,
          transactionBalanceModel: state.transactionBalanceModel,
          vendorRatingsModel: vendorRatings.isNotEmpty
              ? vendorRatingsFromMap(vendorRatings)
              : null,
          transactionHistory: state.transactionHistory.reversed.toList(),
          profileModel: state.profileModel,
          isDatabaseEmpty: state.isDatabaseEmpty));
    });
  }

  void uploadID({required BuildContext context, required imagePath}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    profileDetailsImp.uploadID(
        email: userData.email, context: context, imagePath: imagePath);
  }

  void getProfileDetails() {
    var userData = tempDataBaseImpl.getUserData();
    var image = tempDataBaseImpl.getUserImage();
    var vendorRatings = tempDataBaseImpl.getVendorRating();

    if (userData.isNotEmpty) {
      emit(ProfileState(
          profilePic: profilePicFromMap(image),
          transactionBalanceModel: state.transactionBalanceModel,
          vendorRatingsModel: vendorRatings.isNotEmpty
              ? vendorRatingsFromMap(vendorRatings)
              : null,
          transactionHistory: state.transactionHistory.reversed.toList(),
          profileModel: profileModelFromMap(userData),
          isDatabaseEmpty: userData.isEmpty));
    } else {
      _emitCurrentState();
    }
  }

  void getTransactionHistory({required BuildContext context}) {
    if (tempDataBaseImpl.getUserData().isNotEmpty) {
      transactionHistoryImp
          .transactionsHistory(
              email: profileModelFromMap(tempDataBaseImpl.getUserData())
                  .userDetails
                  .email,
              context: context)
          .then((value) => {
                state.transactionHistory.removeWhere(
                    (e) => value.any((element) => e.id == element.id)),
                state.transactionHistory.addAll(value),
                emit(ProfileState(
                    profilePic: state.profilePic,
                    profileModel: state.profileModel,
                    vendorRatingsModel: state.vendorRatingsModel,
                    transactionHistory:
                        state.transactionHistory.reversed.toList(),
                    transactionBalanceModel: transactionBalanceModelFromMap(
                        tempDataBaseImpl.getUserBalance()),
                    isDatabaseEmpty: state.isDatabaseEmpty))
              });
    }
  }
}
