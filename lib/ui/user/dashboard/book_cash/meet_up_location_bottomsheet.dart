import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/user/dashboard/book_cash/book_cash_screen.dart';
import 'package:flutter/material.dart';

import '../../../global_widgets/global_text_field.dart';

class MeetUpLocationBottomSheet extends StatefulWidget {
  const MeetUpLocationBottomSheet({Key? key}) : super(key: key);

  @override
  State<MeetUpLocationBottomSheet> createState() =>
      _MeetUpLocationBottomSheetState();
}

class _MeetUpLocationBottomSheetState extends State<MeetUpLocationBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
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
                    textController: locationController),
              ),
              const SizedBox(height: 90),
              GlobalButton(
                  buttonText: 'Continue',
                  onTap: () {
                    if (formKey.validate) {
                      meetUpLocation.value = locationController.text;
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
