import 'package:core/core.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:user/src/ui/banks/search_text_field.dart';

class SearchBankBottomSheet extends StatefulWidget {
  const SearchBankBottomSheet({Key? key, required this.accountNumber})
      : super(key: key);

  final String accountNumber;

  @override
  State<SearchBankBottomSheet> createState() => _SearchBankBottomSheetState();
}

class _SearchBankBottomSheetState extends State<SearchBankBottomSheet> {
  final GlobalKey<FormState> bankKey = GlobalKey();
  final bankController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Pick a Bank',
                style: GlobalTextStyles.greenMediumText(
                    context: context, fontSize: 16),
              ),
              SearchTextField(
                  fieldName: 'Search', textController: bankController),
              const SizedBox(height: 20),
              SearchContent(accountNumber: widget.accountNumber)
            ],
          ),
        ),
      ),
    );
  }
}

class SearchContent extends ConsumerStatefulWidget {
  const SearchContent({Key? key, required this.accountNumber})
      : super(key: key);

  final String accountNumber;

  @override
  ConsumerState<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends ConsumerState<SearchContent> {
  List<BankInfoModel> bankList = [];
  List<BankInfoModel> bank = [];

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileViewModelProviderV1);
        return ValueListenableBuilder(
            valueListenable: filterText,
            builder: (context, String filterValue, child) {
              if (bankList.isNotEmpty) {
                bank = bankList
                    .where((item) => item.bankName.contains(filterValue))
                    .toList();

                return Expanded(
                  child: ListView.builder(
                      itemCount: bank.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => profile
                                .verifyAccountNumber(
                                accountNumber: widget.accountNumber,
                                bankName: bank[index].bankName,
                                bankCode: bank[index].bankCode,
                                context: context),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                bank[index].bankName,
                                style: GlobalTextStyles.blueMediumText(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        FadeShimmer(
                          height: 6,
                          width: 250,
                          radius: 4,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: 10),
                        FadeShimmer(
                          height: 6,
                          width: 380,
                          radius: 4,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: 10),
                        FadeShimmer(
                          height: 6,
                          width: 300,
                          radius: 4,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        FadeShimmer(
                          height: 6,
                          width: 250,
                          radius: 4,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: 10),
                        FadeShimmer(
                          height: 6,
                          width: 380,
                          radius: 4,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: 10),
                        FadeShimmer(
                          height: 6,
                          width: 300,
                          radius: 4,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    )
                  ],
                );
              }
            });

  }
}
