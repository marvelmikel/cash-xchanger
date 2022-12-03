import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../cubit/profile_cubit/profile_cubit.dart';
import '../../dependency/get_it.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';
import '../service.dart';
import 'key.dart';

class PaystackPayment {
  final PaystackPlugin _paystack = PaystackPlugin();

  //GetUi
  PaymentCard _getCardUI() {
    return PaymentCard(number: '', cvc: '', expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await _paystack.initialize(publicKey: ConstantKey.paystackKey);
  }

  chargeCardAndMakePayment(
      {required BuildContext context,
      required int price,
      required String accessCode,
      required reference,
      required String email}) async {
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..accessCode = accessCode
        ..card = _getCardUI();

      CheckoutResponse response = await _paystack.checkout(
        context,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        // logo: SvgPicture.asset('assets/images/logo.svg', height: 30),
      );

      if (response.status == true) {
        try {
          final uri = Uri.https(cxHead, 'payment/fund/verify', {
            'APIKey':
                'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6&reference',
            'reference': reference
          });
          client.get(uri, headers: header).timeout(const Duration(seconds: 10),
              onTimeout: () {
            var errorMessage = 'The connection has timed out, Please try again';
            throw TimeoutException(errorMessage);
          });
          context.read<ProfileCubit>().getTransactionHistory(context: context);

          // if ()
          getItInstance<NavigationServiceImpl>().navigateTo(
              Routes.successScreen,
              arguments: 'Cash deposit successful');
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
