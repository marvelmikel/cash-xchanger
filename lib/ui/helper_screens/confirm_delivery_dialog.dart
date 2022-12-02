import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_gray_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/book_cash_cubit/book_cash_cubit.dart';

class ConfirmDeliveryDialog extends StatelessWidget {
  ConfirmDeliveryDialog({Key? key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 220, horizontal: 45),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/increase_money.svg', height: 70),
            const SizedBox(height: 40),
            Text(
              'Confirm delivery',
              style: GlobalTextStyles.blueMediumTextB(
                  context: context, fontSize: 20),
            ),
            const SizedBox(height: 15),
            const Text(
              'Have you received requested cash '
              'at stipulated meetup location?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: GlobalGrayButton(
                    buttonText: 'Not yet',
                    height: 50,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GlobalButton(
                    buttonText: 'Delivered',
                    isButtonColorGreen: true,
                    height: 50,
                    onTap: () => context
                        .read<BookCashCubit>()
                        .completeTransaction(context: context),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
