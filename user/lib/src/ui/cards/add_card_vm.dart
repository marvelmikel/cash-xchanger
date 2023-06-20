import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:user/src/data/user_api_calls.dart';
import 'package:user/src/ui/cards/select_card_screen/paystack_payment.dart';

final addCardVM = ChangeNotifierProvider((ref) => AddCardVM(ref));

class AddCardVM extends ChangeNotifier {
  final Ref ref;

  AddCardVM(this.ref);

  Future<void> addCardDetails(
      {required BuildContext context,
      required String cardNumber,
      required String cardName,
      required String expiryYear,
      required String expiryMonth,
      required bool isDefault,
      required String cvv}) async {
    await ref
        .read(userApiProvider)
        .initCardAdding(amount: "0", isDefault: isDefault).then((value) {

          print("this is the response ${value.toJson()}");
      PaystackPayment().chargeCardAndMakePayment(
          context: context,
          price: 0,
          email: ref.read(profileViewModelProviderV1).currentUser.email!,
          paymentCard: PaymentCard(
              number: cardNumber,
              cvc: cvv,
              expiryMonth: int.tryParse(expiryMonth),
              expiryYear: int.tryParse(expiryYear)),
          accessCode: value.accessCode!,
          reference: value.reference!);
    });
  }
}
