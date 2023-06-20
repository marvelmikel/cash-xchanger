import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:user/src/ui/cash_request/cash_request.dart';

class MeetUpLocationBottomSheet extends ConsumerStatefulWidget {
  const MeetUpLocationBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<MeetUpLocationBottomSheet> createState() =>
      _MeetUpLocationBottomSheetState();
}

class _MeetUpLocationBottomSheetState
    extends ConsumerState<MeetUpLocationBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final locationController = TextEditingController();
  bool isVisible = true;
  String query = '';
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cashRequstVM);
    return Container(
      height: 650,
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
              Text('Meet up location',
                  style: GlobalTextStyles.blueMediumTextB(
                      context: context, fontSize: 20)),
              Form(
                key: formKey,
                child: GlobalTextField(
                    fieldName: 'Meet up location',
                    keyBoardType: TextInputType.text,
                    maxLength: 400,
                    removeSpace: false,
                    onChange: (keyword) {
                      print("this is the keyword $keyword");
                      if (keyword != '') {
                        setState(() {
                          isVisible = false;
                          query = keyword;
                          //  cost = value;
                        });
                      } else {
                        setState(() {
                          isVisible = true;
                          query = '';
                        });
                      }
                    },
                    textController: locationController),
              ),
              //   Consumer(builder: builder),
              isVisible
                  ? SizedBox(height: 90)
                  : Consumer(builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                      final chargeRef = ref.watch(autoCompleteProvider(query));

                      return chargeRef.when(
                          data: (data) {
                            return Expanded(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    AutoCompleteFeatures features =
                                        data.features![index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          locationController.text =
                                              features.properties!.label!;
                                          addData(state);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 4.0),
                                        child: Text(features.properties!.label!,
                                            style: GlobalTextStyles.regularText(
                                              context: context,
                                              fontSize: 13,
                                            )),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(
                                              height: 1,
                                              color: GlobalColors.primaryGreen),
                                  itemCount: data.features!.length),
                            );
                          },
                          error: (error, stacktrcar) {
                            return Text(error.toString());
                          },
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ));
                    }),
              GlobalButton(title: 'Continue', onPressed: () => addData(state))
            ],
          ),
        ),
      ),
    );
  }

  addData(CashRequestVM state) {
    if (formKey.currentState!.validate()) {
      state.setMeetupLocation(locationController.text);
      Navigator.pop(context);
    }
  }
}

final autoCompleteProvider =
    FutureProvider.family<AutoCompleteModel, String>((ref, query) async {
  final locationSearch =
      await DirectionsRepository().getOpenAutoComplete(query: query);
  return locationSearch!;
});
