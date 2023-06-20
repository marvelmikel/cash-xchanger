import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:sizer/sizer.dart';
import 'package:shared/src/datasource/models/transactions/transaction_model.dart';

import 'dashboard_vm.dart';

class BalanceWidget extends ConsumerStatefulWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends ConsumerState<BalanceWidget> {
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(profileViewModelProviderV1);
    final userDash = ref.watch(userDashVM);
    final navigation = ref.watch(navProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      width: GlobalSizes.globalWidth(context, 1),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MenuBar(
            scafoldKey: userDash.scaffoldKey,
            leadingMsg: 'How much cash do you need today',
            nameLabel: controller.currentUser.fullName,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 55.w,
                    child: EditTextField(
                      textController: amountController,
                      formatter: userDash.amountFormatter,
                      isCurrency: true,
                      padding: 5,
                      onChange: userDash.textChange,
                    ),
                  ),
                  userDash.isVisible
                      ? const SizedBox(
                          height: 20,
                        )
                      : InkWell(
                          onTap: userDash.toggleOnTap,
                          child: Consumer(builder: (BuildContext context,
                              WidgetRef ref, Widget? child) {
                            final chargeRef =
                                ref.watch(userProvider(userDash.cost));

                            return chargeRef.when(
                                data: (data) {
                                  // bookingData.value.charge =
                                  //     data.fee.toString();
                                  return SimpleTooltip(
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    ballonPadding: const EdgeInsets.all(8),
                                    tooltipDirection: TooltipDirection.down,
                                    backgroundColor: Colors.white,
                                    borderWidth: 0,
                                    maxWidth: 100.w,
                                    minWidth: 50.w,
                                    maxHeight: 17.h,
                                    arrowLength: 0,
                                    arrowBaseWidth: 13,
                                    arrowTipDistance: 4,
                                    hideOnTooltipTap: true,
                                    customShadows: const [
                                      BoxShadow(
                                        color: Colors.transparent,
                                      ),
                                    ],
                                    show: userDash.tapped,
                                    content: Content(
                                      charges: data,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 10),

                                      ///formatFiguresSeparator(double.parse(data.charge ?? '299')
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              'N${formatFiguresSeparator(data.fee!.toDouble())} processing fee : N${formatFiguresSeparator(data.total!.toDouble())}',
                                              style: GlobalTextStyles
                                                  .greenMediumText(
                                                context: context,
                                                fontSize: 13,
                                              ).copyWith(
                                                  color:
                                                      GlobalColors.lightGreen)),
                                          Text(
                                            'See breakdown',
                                            style: GlobalTextStyles
                                                .greenMediumText(
                                              context: context,
                                              fontSize: 13,
                                            ).copyWith(
                                              color: GlobalColors.lightGreen,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                error: (error, stacktrcar) => Container(),
                                loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ));
                          }),
                        )
                ],
              )),
              GlobalButton(
                title: 'Request',
                onPressed: () =>
                    navigation.navigateTo(Routes.meetUpLocationScreen),
                disableOpacity: 0.5,
                width: 30.w,
                isDisabled: userDash.isVisible,
                foreground: Colors.white,
                height: 7,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );

    // Future getCharge() async {
    //   if (isVisible) {
    //     return context.read<BookCashCubit>().getTransactionCharges(cost: cost);
    //   }
  }
}

class Content extends StatelessWidget {
  final TransactionCharges charges;
  const Content({Key? key, required this.charges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Fee Breakdown',
            style:
                GlobalTextStyles.blueMediumText(context: context, fontSize: 18),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Requested Cash: '),
              Text('N${formatFiguresSeparator(charges.amount!.toDouble())}',
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 14)),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Vendor Charge: '),
              Text('N${formatFiguresSeparator(charges.fee!.toDouble())}',
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 14)),
            ],
          ),
          Container(
            width: 35.w,
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Total: '),
                Text('N${formatFiguresSeparator(charges.total!.toDouble())}',
                    style: GlobalTextStyles.blueMediumText(
                        context: context, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
