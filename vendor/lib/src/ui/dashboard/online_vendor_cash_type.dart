
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class OnlineVendorCashType extends StatelessWidget {
  const OnlineVendorCashType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 265, horizontal: 50),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('What cash type do you possess?',
                textAlign: TextAlign.center,
                style: GlobalTextStyles.regularMediumH(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Tell us the cash type you want to provide.',
                textAlign: TextAlign.center),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    // onTap: () => getItInstance<VendorCubit>()
                    //     .online(cashType: 'mint', context: context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: GlobalColors.primaryBlue),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Mint Cash'),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    // onTap: () => getItInstance<VendorCubit>()
                    //     .online(cashType: 'stale', context: context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: GlobalColors.primaryBlue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Stale Cash',
                          style: GlobalTextStyles.regularMediumWhite(
                              fontSize: 16)),
                    ),
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
