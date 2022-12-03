import 'package:cash_xchanger/navigation/routes.dart';
import 'package:cash_xchanger/ui/login_screen/login_screen.dart';
import 'package:cash_xchanger/ui/overview_screen/overview_screen.dart';
import 'package:cash_xchanger/ui/sign_up_screen/user_sign_up_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../home_page.dart';
import '../ui/confirmation_screen/confirmation_screens.dart';
import '../ui/helper_screens/success_screen.dart';
import '../ui/shared_ui/enter_pin_screen/enter_pin_screen.dart';
import '../ui/shared_ui/navigation_drawer/account_info/account_info_screen.dart';
import '../ui/shared_ui/navigation_drawer/notifications/notification_screen.dart';
import '../ui/shared_ui/navigation_drawer/notifications/read_notification_screen.dart';
import '../ui/shared_ui/navigation_drawer/payment_methods/add_card_screen/add_card_screen.dart';
import '../ui/shared_ui/navigation_drawer/payment_methods/fund_wallet_screen/fund_wallet_screen.dart';
import '../ui/shared_ui/navigation_drawer/payment_methods/payment_methods.dart';
import '../ui/shared_ui/navigation_drawer/scheduled_transfers/scheduled_transfers.dart';
import '../ui/shared_ui/navigation_drawer/settings/settings_screen.dart';
import '../ui/shared_ui/navigation_drawer/settings/verify_password_screen.dart';
import '../ui/shared_ui/withdrwal_screen/withdraw_funds.dart';
import '../ui/shared_ui/withdrwal_screen/withdraw_screen.dart';
import '../ui/user/dashboard/book_cash/book_cash_screen.dart';
import '../ui/user/dashboard/book_cash/connect_vendor/connect_vendor_screen.dart';
import '../ui/user/dashboard/book_cash/connect_vendor/request_cash_screen/request_cash_screen.dart';
import '../ui/user/dashboard/book_cash/meet_up_location_screen/meet_up_location_screen.dart';
import '../ui/user/dashboard/dashboard_home/user_dashboard_screen.dart';
import '../ui/vendor/vendor_dashboard/vendor_dashboar.dart';
import '../ui/vendor/vendor_welcome_screen.dart';

class GlobalRouter {
  GlobalRouter._();

  static generateRoutes(settings) {
    switch (settings.name) {
      // Auth and onboarding
      case Routes.homePage:
        return PageTransition(
            child: const HomePage(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.overViewScreen:
        return PageTransition(
            child: const OverviewScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.signUpScreen:
        return PageTransition(
            child: const UserSignUpScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.loginScreen:
        return PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.confirmationScreen:
        return PageTransition(
            child: ConfirmationScreen(user: settings.arguments as String),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.vendorWelcomeScreen:
        return PageTransition(
            child: VendorWelcomeScreen(vendorData: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);
        
        case Routes.verifyEmailScreen:
        return PageTransition(
            child: const VerifyEmailScreen(),
            type: PageTransitionType.fade,
            settings: settings);

        case Routes.verifyEmailPromptScreen:
        return PageTransition(
            child: const VerifyEmailPromptScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      // Vendor screen
      case Routes.vendorDashboard:
        return PageTransition(
            child: const VendorDashboard(),
            type: PageTransitionType.fade,
            settings: settings);

      // User screen
      case Routes.userDashBoard:
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
            child: const ScheduledTransfers(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.notificationScreen:
        return PageTransition(
            child: NotificationScreen(email: settings.arguments as String),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.readNotificationScreen:
        return PageTransition(
            child: ReadNotificationScreen(userNotification: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.paymentMethods:
        return PageTransition(
            child: const PaymentMethods(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.settingsScreen:
        return PageTransition(
            child: const SettingsScreen(),
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
            child: const FundWalletScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.successScreen:
        return PageTransition(
            child: SuccessScreen(successText: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.withdrawFundsScreen:
        return PageTransition(
            child: const WithdrawFundsScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.withdrawScreen:
        return PageTransition(
            child: const WithdrawScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.enterPinScreen:
        return PageTransition(
            child: EnterPinScreen(amount: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.bookCashScreen:
        return PageTransition(
            child: const BookCashScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.meetUpLocationScreen:
        return PageTransition(
            child: const MeetUpLocationScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.connectVendorScreen:
        return PageTransition(
            child: const ConnectVendorScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case Routes.requestCashScreen:
        return PageTransition(
            child: RequestCashScreen(location: settings.arguments),
            type: PageTransitionType.fade,
            settings: settings);
    }
  }
}
