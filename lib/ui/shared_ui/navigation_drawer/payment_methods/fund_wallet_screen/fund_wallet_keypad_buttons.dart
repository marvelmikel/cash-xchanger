import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'fund_wallet_button_widget.dart';

class FundWalletKeypadButtons extends StatelessWidget {
  const FundWalletKeypadButtons({Key? key, required this.textController})
      : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: keypadEquation,
        builder: (context, String value, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FundWalletKeypadButtonWidget(
                          buttonText: '1', textController: textController),
                      FundWalletKeypadButtonWidget(
                          buttonText: '2', textController: textController),
                      FundWalletKeypadButtonWidget(
                          buttonText: '3', textController: textController),
                    ]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FundWalletKeypadButtonWidget(
                          buttonText: '4', textController: textController),
                      FundWalletKeypadButtonWidget(
                          buttonText: '5', textController: textController),
                      FundWalletKeypadButtonWidget(
                          buttonText: '6', textController: textController),
                    ]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FundWalletKeypadButtonWidget(
                          buttonText: '7', textController: textController),
                      FundWalletKeypadButtonWidget(
                          buttonText: '8', textController: textController),
                      FundWalletKeypadButtonWidget(
                          buttonText: '9', textController: textController),
                    ]),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('          '),
                      FundWalletKeypadButtonWidget(
                          buttonText: '0', textController: textController),
                      InkWell(
                        onTap: () => FundWalletKeypadButtonWidget(
                                buttonText: '⌫', textController: textController)
                            .calculation(context, '⌫', value),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                'assets/images/back_icon.svg')),
                      ),
                    ]),
              ],
            ),
          );
        });
  }
}
