import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:user/user.dart';
import 'package:vendor/vendor.dart';

import 'routes.dart';
import 'package:page_transition/page_transition.dart';

class GlobalRouter {
  GlobalRouter._();

  static generateRoutes(settings) {
    switch (settings.name) {
      // Auth and onboarding
      case Routes.homePage:
        return PageTransition(
            //  child: const HomePage(),
            child: OnboardScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.overViewScreen:
        return PageTransition(
            child: OverviewScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.signUpScreen:
        return PageTransition(
            child: UserSignUpScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.loginScreen:
        return PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.confirmationScreen:
        return PageTransition(
            child: ConfirmationScreen(user: settings.arguments ?? ""),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.vendorKycScreen:
        return PageTransition(
            child: const VendorWelcomeScreen(),
            type: PageTransitionType.fade,
            settings: settings);
      case Routes.initReset:
        return PageTransition(
            child: const InitResetScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.changePassword:
        return PageTransition(
            child: const PasswordReset(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.passwordRest:
        return PageTransition(
            child: const ChangePasswordScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.transactionScreen:
        return PageTransition(
            child: TransactionsScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.verifyPhoneScreen:
        PinType args = settings.arguments ?? PinType.signup;
        return PageTransition(
            child: VerifyPhoneScreen(pinType: args),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.verifyEmailPromptScreen:
        return PageTransition(
            child: const VerifyEmailPromptScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.privacyScreen:
        return PageTransition(
            child: const TermsAndConditionsScreen(),
            type: PageTransitionType.fade,
            settings: settings);
      // Vendor screen
      case Routes.vendorDashboard:
        print("Navigation call made to Vendor Dash");
        return PageTransition(
            child: const VendorDashboard(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.vendorRequestScreen:
        //  InitCashPayload args = settings.arguments as InitCashPayload;
        return PageTransition(
            child: Container(),
            //child: const VendorCashRequestScreen(
            //   cashPayload: args,
            //  ),
            type: PageTransitionType.fade,
            settings: settings);

      // User screen
      case Routes.userDashBoard:
        print("Navigation call made to user Dash");
        return PageTransition(
            child: const UserDashBoardScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      // Nav Drawer
      case Routes.accountInfoScreen:
        return PageTransition(
            child: const AccountInfoScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.scheduledTransfers:
        return PageTransition(
            // child: const ScheduledTransfers(),
            child: Container(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.notificationScreen:
        return PageTransition(
            child: const NotificationScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.readNotificationScreen:
        return PageTransition(
            child: ReadNotificationScreen(userNotification: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.paymentMethods:
        return PageTransition(
            child: PaymentMethods(paymentType: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.settingsScreen:
        return PageTransition(
            child: const SettingsScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.promotionsScreen:
        return PageTransition(
            child: const PromotionsScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.verifyPasswordScreen:
        return PageTransition(
            child: VerifyPasswordScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.addCardScreen:
        return PageTransition(
            child: const AddCardScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.fundWalletScreen:
        return PageTransition(
            // child: const FundWalletScreen(),
            child: Container(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.successScreen:
        return PageTransition(
            child: SuccessScreen(successText: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.withdrawFundsScreen:
        return PageTransition(
            //   child: const WithdrawFundsScreen(),
            child: Container(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.withdrawScreen:
        return PageTransition(
            //  child: const WithdrawScreen(),
            child: Container(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.enterPinScreen:
        return PageTransition(
            // child: EnterPinScreen(amount: settings.arguments),
            child: Container(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.bookCashScreen:
        return PageTransition(
            //   child: const BookCashScreen(),
            child: Container(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.meetUpLocationScreen:
        return PageTransition(
            child: const MeetUpLocationScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.fullMapScreen:
        return PageTransition(
            child: const FullMapScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.connectVendorScreen:
        ConnectParams params = settings.arguments as ConnectParams;
        return PageTransition(
            child: ConnectVendorScreen(
              params: params,
            ),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.requestCashScreen:
        return PageTransition(
            child: Container(),
            //   child: RequestCashScreen(location: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);
    }
  }
}
