import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/svg.dart';
import 'package:shared/shared.dart';
import 'package:user/src/ui/banks/add_banks_modal.dart';


class BankCarousel extends ConsumerStatefulWidget {
  const BankCarousel({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BankCarousel> createState() => _BankCarouselState();
}

class _BankCarouselState extends ConsumerState<BankCarousel> {
  @override
  void initState() {
  //  context.read<NavDrawerCubit>().getBankAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final profile = ref.watch(profileViewModelProviderV1);
    PageController pageController =
        PageController(initialPage: 0, viewportFraction: 0.85);

        return Column(
          children: [
            GestureDetector(
              onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddBankBottomSheet()),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/bank_icon.svg'),
                          const SizedBox(width: 20),
                          Text('Banks',
                              style: GlobalTextStyles.regularText(
                                  context: context, fontSize: 18)),
                          const SizedBox(width: 20),
                          SvgPicture.asset('assets/images/circle_plus_icon.svg')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: profile.userBanks.isEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        SvgPicture.asset('assets/images/no_card.svg',
                            height: 70),
                        const SizedBox(height: 10),
                        const Text('No account added')
                      ],
                    )
                  : MediaQuery.removePadding(
                      context: context,
                      removeLeft: true,
                      child: PageView(
                        controller: pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: _listOfCardWidgets(profile.userBanks),
                      ),
                    ),
            )
          ],
        );

  }
}

List<Widget> _listOfCardWidgets(List<Banks> bankList) {
  List<Widget> _listOfBanks = [];

  for (int index = 0; index < bankList.length; index++) {
    _listOfBanks.add(
      _BankWidget(bankDetail: bankList[index]),
    );
  }

  return _listOfBanks;
}

class _BankWidget extends StatelessWidget {
  const _BankWidget({Key? key, required this.bankDetail}) : super(key: key);

  final Banks bankDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
          color: GlobalColors.primaryGreen.withAlpha(50),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(bankDetail.accountName,
              style: GlobalTextStyles.regularGreenTexMedium(
                  context: context, fontSize: 22)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bankDetail.bank,
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 14)),
              Text(bankDetail.bankAccountNo,
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }
}



