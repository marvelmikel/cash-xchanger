import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class PaystackPayment {
  final PaystackPlugin _paystack = PaystackPlugin();

  Future initializePlugin() async {
    await _paystack.initialize(publicKey: ConstantKey.paystackKey);
  }

  NavigationService nav = NavigationServiceImpl();

  chargeCardAndMakePayment(
      {required BuildContext context,
        required int price,
        required String accessCode,
        required reference,

        required PaymentCard paymentCard,
        required String email}) async {
    initializePlugin().then((_) async {
      debugPrint("this is the payment card $paymentCard");
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..accessCode = accessCode
        ..bearer
        ..card = paymentCard;

      CheckoutResponse response = await _paystack.checkout(
        context,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: true,
        // logo: SvgPicture.asset('assets/images/logo.svg', height: 30),
      );
      debugPrint('this is the response form Paystack ${response.toString()}');

      if (response.status == true) {
        try {
          // if ()
          nav.navigateTo(Routes.successScreen, arguments: 'Successful');
          debugPrint('Transaction verified');
          // }
        } catch (_) {
          debugPrint('Unable to verify transaction');
        }
      } else {
        var snackBar = const SnackBar(content: Text('Transaction failed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
