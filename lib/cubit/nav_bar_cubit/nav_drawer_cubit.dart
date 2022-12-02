import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/notifications_api/notification_api.dart';
import '../../api_service/payments_api/list_of_card_api.dart';
import '../../api_service/security/security_api.dart';
import '../../database/models/banks_model/bank_model.dart';
import '../../database/models/cards_model/card_model.dart';
import '../../database/models/notifications_model/notification_model.dart';
import '../../database/models/profile_model/profile_model.dart';
import '../../database/shared_preferences/temp_database.dart';

class NavDrawerState {
  List<UserNotification> listOfNotifications;
  List<CardDetail> listOfCards;
  List<BankDetail> listOfBanks;
  bool isLoading;

  NavDrawerState(
      {required this.listOfNotifications,
      required this.listOfBanks,
      required this.isLoading,
      required this.listOfCards});
}

class NavDrawerCubit extends Cubit<NavDrawerState> {
  NotificationServiceImp notificationServiceImp;
  CardServiceImpl cardServiceImpl;
  TempDataBaseImpl tempDataBaseImpl;
  SecurityImp securityImp;

  NavDrawerCubit(
      {required this.notificationServiceImp,
      required this.cardServiceImpl,
      required this.securityImp,
      required this.tempDataBaseImpl})
      : super(NavDrawerState(
            listOfNotifications: [],
            listOfCards: [],
            listOfBanks: [],
            isLoading: false));

  void getNotifications({required BuildContext context}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    emit(NavDrawerState(
        listOfCards: state.listOfCards,
        listOfBanks: state.listOfBanks,
        listOfNotifications: state.listOfNotifications,
        isLoading: true));
    notificationServiceImp
        .getNotifications(email: userData.email, context: context)
        .then((value) => {
              emit(NavDrawerState(
                  listOfNotifications: value,
                  listOfCards: state.listOfCards,
                  listOfBanks: state.listOfBanks,
                  isLoading: false))
            });
  }

  void markNotificationAsRead(
      {required BuildContext context, email, notificationRef}) {
    notificationServiceImp
        .markAsRead(notificationRef: notificationRef)
        .then((value) => getNotifications(context: context));
  }

  void getCards() {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    cardServiceImpl.getCards(email: userData.email).then((value) => emit(
        NavDrawerState(
            listOfNotifications: state.listOfNotifications,
            listOfBanks: state.listOfBanks,
            listOfCards: value.isEmpty ? state.listOfCards : value,
            isLoading: false)));
  }

  void getBankAccounts() {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    cardServiceImpl.getBanks(email: userData.email).then((value) => emit(
        NavDrawerState(
            listOfNotifications: state.listOfNotifications,
            listOfBanks: value.isEmpty ? state.listOfBanks : value,
            listOfCards: state.listOfCards,
            isLoading: false)));
  }

  void verifyPassword({required BuildContext context, required password}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    securityImp.verifyPassword(
        email: userData.email, context: context, password: password);
  }

  void addPin({required BuildContext context, required pin}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    securityImp.addPin(email: userData.email, context: context, userPin: pin);
  }
}
