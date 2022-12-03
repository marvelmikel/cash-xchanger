import 'dart:convert';

import 'package:cash_xchanger/database/models/profile_model/profile_model.dart';
import 'package:cash_xchanger/database/models/transaction_history_and_balance_model/transaction_balance_model.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../../api_service/nearby_vendor/nearby_vendor_api.dart';
import '../../database/models/temp_cash_model/temp_cash_model.dart';
import '../../database/shared_preferences/temp_database.dart';
import '../../ui/user/dashboard/book_cash/book_cash_screen.dart';

class BookCashState {
  String amount;
  String fiftyNaira;
  String hundredNaira;
  String twoHundredNaira;
  String fiveHundredNaira;
  String oneThousandNaira;
  String balance;
  TempCashModel? tempCashModel;

  BookCashState(
      {required this.amount,
      required this.fiftyNaira,
      required this.hundredNaira,
      required this.twoHundredNaira,
      required this.fiveHundredNaira,
      required this.oneThousandNaira,
      required this.balance,
      required this.tempCashModel});
}

class BookCashCubit extends Cubit<BookCashState> {
  TempDataBaseImpl tempDataBaseImpl;
  NearbyVendorApiServiceImpl nearbyVendorApiServiceImpl;

  BookCashCubit(
      {required this.tempDataBaseImpl,
      required this.nearbyVendorApiServiceImpl})
      : super(BookCashState(
            amount: '',
            fiftyNaira: '',
            hundredNaira: '',
            twoHundredNaira: '',
            fiveHundredNaira: '',
            oneThousandNaira: '',
            balance: '',
            tempCashModel: null));

  void checkAvailableData() {
    if (tempDataBaseImpl.getUnfinishedTransaction().isNotEmpty) {
      var unfinishedTransaction =
          tempCashModelFromMap(tempDataBaseImpl.getUnfinishedTransaction());

      switchCards.value = tempDataBaseImpl.getCashBooking();
      var denominations =
          unfinishedTransaction.nearestVendors.cashSummary.denominations;

      emit(BookCashState(
          amount: unfinishedTransaction.nearestVendors.cashSummary.cashAmount
              .toString(),
          fiftyNaira: denominations.fifty.toString(),
          hundredNaira: denominations.hundred.toString(),
          twoHundredNaira: denominations.twoHundred.toString(),
          fiveHundredNaira: denominations.fiveHundred.toString(),
          oneThousandNaira: denominations.oneThousand.toString(),
          tempCashModel: unfinishedTransaction,
          balance:
              profileModelFromMap(tempDataBaseImpl.getUserData()).userBalance));
    }
  }

  void checkAvailabilityAndNavigate() {
    if (tempDataBaseImpl.getUnfinishedCashOrder().isNotEmpty) {
      getItInstance<NavigationServiceImpl>()
          .navigateTo(Routes.meetUpLocationScreen);
    } else if (tempDataBaseImpl.getUnfinishedTransaction().isNotEmpty) {
      var unfinishedTransaction =
          tempCashModelFromMap(tempDataBaseImpl.getUnfinishedTransaction());
      getItInstance<NavigationServiceImpl>()
          .navigateTo(Routes.requestCashScreen, arguments: [
        double.tryParse(unfinishedTransaction.nearestVendors.vendorLat),
        double.tryParse(unfinishedTransaction.nearestVendors.vendorLong)
      ]);
    } else {
      getItInstance<NavigationServiceImpl>().navigateTo(Routes.bookCashScreen);
    }
  }

  void cancelBooking({required BuildContext context}) {
    nearbyVendorApiServiceImpl.cancelBooking(context: context);
  }

  void saveCashDetails({required Map<String, String> cashData}) {
    tempDataBaseImpl.saveUnfinishedCashOrder(transaction: jsonEncode(cashData));
    emit(BookCashState(
        amount: cashData['cash_amount']!,
        fiftyNaira: cashData['fifty']!,
        hundredNaira: cashData['hundred']!,
        twoHundredNaira: cashData['two_hundred']!,
        fiveHundredNaira: cashData['five_hundred']!,
        oneThousandNaira: cashData['one_thousand']!,
        tempCashModel: state.tempCashModel,
        balance: state.balance));
  }

  void getBalance() {
    if (tempDataBaseImpl.getUnfinishedCashOrder().isNotEmpty) {
      var cashData = jsonDecode(tempDataBaseImpl.getUnfinishedCashOrder());
      emit(BookCashState(
          amount: cashData['cash_amount'],
          fiftyNaira: cashData['fifty'],
          hundredNaira: cashData['hundred'],
          twoHundredNaira: cashData['two_hundred'],
          fiveHundredNaira: cashData['five_hundred'],
          oneThousandNaira: cashData['one_thousand'],
          tempCashModel: state.tempCashModel,
          balance: cashData['balance']));
    }
    emit(BookCashState(
        amount: state.amount,
        fiftyNaira: state.fiftyNaira,
        hundredNaira: state.hundredNaira,
        twoHundredNaira: state.twoHundredNaira,
        fiveHundredNaira: state.fiveHundredNaira,
        oneThousandNaira: state.oneThousandNaira,
        tempCashModel: state.tempCashModel,
        balance:
            transactionBalanceModelFromMap(tempDataBaseImpl.getUserBalance())
                .userBalance));
  }

  void confirmBooking({required BuildContext context}) async {
    nearbyVendorApiServiceImpl.confirmBooking(context: context);
  }

  void completeTransaction({required BuildContext context}) async {
    nearbyVendorApiServiceImpl.completeTransaction(context: context);
  }

  void getNearbyVendor({required BuildContext context}) async {
    late Position userPosition;
    bool isServiceEnabled;

    await Geolocator.requestPermission();
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isServiceEnabled) {
      userPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      var cashData = {
        'lat': userPosition.latitude,
        'long': userPosition.longitude,
        'meetup_location': meetUpLocation.value,
        'cash_type': cashType.value ? 'stable' : 'mint',
        'cash_summary': '{'
            '"cash_amount": ${state.amount},'
            '"cash_type": "${cashType.value ? 'stable' : 'mint'}]",'
            '"denominations": '
            '{"fifty": ${state.fiftyNaira},'
            '"hundred": ${state.hundredNaira},'
            '"two_hundred": ${state.twoHundredNaira},'
            '"five_hundred": ${state.fiveHundredNaira},'
            '"one_thousand": ${state.oneThousandNaira}}}'
      };
/**
 * '{'
            '\"cash_amount\": ${state.amount},'
            '\"cash_type\": \"${cashType.value ? 'stable' : 'mint'}]\",'
            '\"denominations\": '
            '{\"fifty\": ${state.fiftyNaira},'
            '\"hundred\": ${state.hundredNaira},'
            '\"two_hundred\": ${state.twoHundredNaira},'
            '\"five_hundred\": ${state.fiveHundredNaira},'
            '\"one_thousand\": ${state.oneThousandNaira}}}'
 */
      nearbyVendorApiServiceImpl
          .searchNearbyVendors(
              email: profileModelFromMap(tempDataBaseImpl.getUserData())
                  .userDetails
                  .email,
              context: context,
              cashData: cashData)
          .then((value) {
        if (value) {
          var unfinishedTransaction =
              tempCashModelFromMap(tempDataBaseImpl.getUnfinishedTransaction());
          emit(BookCashState(
              amount: state.amount,
              fiftyNaira: state.fiftyNaira,
              hundredNaira: state.hundredNaira,
              twoHundredNaira: state.twoHundredNaira,
              fiveHundredNaira: state.fiveHundredNaira,
              oneThousandNaira: state.oneThousandNaira,
              tempCashModel: unfinishedTransaction,
              balance: state.balance));
        }
      });
    }
  }

  void scheduleDeliveryLater(
      {required BuildContext context,
      required BookCashState bookCashState}) async {
    if (meetUpLocation.value.isNotEmpty) {
      var cashData = {
        'meetup_location': meetUpLocation.value,
        'cash_type': cashType.value ? 'stable' : 'mint',
        'cash_amount': bookCashState.amount,
        'date_time': DateTime.now().toString(),
        'cash_summary': '{'
            '"cash_amount": ${bookCashState.amount},'
            '"denominations": '
            '{"fifty": ${bookCashState.fiftyNaira},'
            '"hundred": ${bookCashState.hundredNaira},'
            '"two_hundred": ${bookCashState.twoHundredNaira},'
            '"five_hundred": ${bookCashState.fiveHundredNaira},'
            '"one_thousand": ${bookCashState.oneThousandNaira}}}'
      };
      nearbyVendorApiServiceImpl.scheduleDeliveryLater(
          context: context, cashData: cashData);
    } else {
      Fluttertoast.showToast(msg: 'Pls add meet up location');
    }
  }
}
