import 'package:cash_xchanger/api_service/transactions_api/transaction_api.dart';
import 'package:cash_xchanger/cubit/vendor_cubit/vendor_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service/auth_api/auth_api.dart';
import '../api_service/auth_api/login_api.dart';
import '../api_service/auth_api/registration_api.dart';
import '../api_service/nearby_vendor/nearby_vendor_api.dart';
import '../api_service/notifications_api/notification_api.dart';
import '../api_service/payments_api/bank_service_api.dart';
import '../api_service/payments_api/list_of_card_api.dart';
import '../api_service/payments_api/top_up_api.dart';
import '../api_service/profile_api/profile_details_api.dart';
import '../api_service/security/security_api.dart';
import '../cubit/auth_cubit/login_cubit.dart';
import '../cubit/auth_cubit/register_cubit.dart';
import '../cubit/book_cash_cubit/book_cash_cubit.dart';
import '../cubit/nav_bar_cubit/nav_drawer_cubit.dart';
import '../cubit/payment_cubit/payment_cubit.dart';
import '../cubit/profile_cubit/profile_cubit.dart';
import '../database/shared_preferences/temp_database.dart';
import '../navigation/navigation_service.dart';

final getItInstance = GetIt.I;

Future initDependencies() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();

  //Storage
  getItInstance.registerSingleton<SharedPreferences>(sharedPref);
  getItInstance.registerLazySingleton<TempDataBaseImpl>(
      () => TempDataBaseImpl(sharedPreferences: getItInstance()));

  // Navigation
  getItInstance.registerLazySingleton<NavigationServiceImpl>(
      () => NavigationServiceImpl());

  // Profile details
  getItInstance.registerLazySingleton<ProfileDetailsImp>(
      () => ProfileDetailsImp(tempDataBaseImpl: getItInstance()));

  // Transaction History
  getItInstance.registerLazySingleton<TransactionHistoryImp>(
      () => TransactionHistoryImp(tempDataBaseImpl: getItInstance()));

  // Security
  getItInstance.registerLazySingleton<SecurityImp>(() => SecurityImp());

  // Auth service
  getItInstance.registerLazySingleton<AuthApiServiceImpl>(() =>
      AuthApiServiceImpl(
          loginServiceImpl: getItInstance(),
          registrationServiceImpl: getItInstance()));

  // Bank Service
  getItInstance.registerLazySingleton<BankImpl>(() => BankImpl());

  // Notification
  getItInstance.registerLazySingleton<NotificationServiceImp>(
      () => NotificationServiceImp());

  getItInstance.registerFactory(() => NavDrawerCubit(
      notificationServiceImp: getItInstance(),
      securityImp: getItInstance(),
      tempDataBaseImpl: getItInstance(),
      cardServiceImpl: getItInstance()));

  // Payment Cubit
  getItInstance.registerFactory(() => PaymentCubit(
      bankImpl: getItInstance(),
      topUpImpl: getItInstance(),
      tempDataBaseImpl: getItInstance()));

  // Cards
  getItInstance.registerLazySingleton<CardServiceImpl>(() => CardServiceImpl());

  // Top Up
  getItInstance.registerLazySingleton<TopUpImpl>(() => TopUpImpl());

  // Login
  getItInstance.registerLazySingleton<LoginServiceImpl>(
      () => LoginServiceImpl(profileDetailsImp: getItInstance()));

  // Registration
  getItInstance.registerLazySingleton<RegistrationServiceImpl>(
      () => RegistrationServiceImpl(profileDetailsImp: getItInstance()));

  // NearbyVendor
  getItInstance.registerLazySingleton<NearbyVendorApiServiceImpl>(
      () => NearbyVendorApiServiceImpl(tempDataBaseImpl: getItInstance()));

  getItInstance.registerFactory(
      () => RegisterCubit(authApiServiceImpl: getItInstance()));

  getItInstance.registerFactory(() => BookCashCubit(
      tempDataBaseImpl: getItInstance(),
      nearbyVendorApiServiceImpl: getItInstance()));

  getItInstance.registerFactory(() => VendorCubit(
      tempDataBaseImpl: getItInstance(),
      nearbyVendorApiServiceImpl: getItInstance()));

  // Login
  getItInstance
      .registerFactory(() => LoginCubit(authApiServiceImpl: getItInstance()));

  // Profile
  getItInstance.registerFactory(() => ProfileCubit(
      tempDataBaseImpl: getItInstance(),
      transactionHistoryImp: getItInstance(),
      profileDetailsImp: getItInstance()));
}
