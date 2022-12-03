import 'dart:convert';
import 'dart:io';

import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

var isIDUploaded = ValueNotifier(false);
var idImageBytes = ValueNotifier<List<int>>([]);

class UploadLicenseBottomSheet extends StatefulWidget {
  const UploadLicenseBottomSheet({Key? key, required this.email})
      : super(key: key);

  final String email;

  @override
  State<UploadLicenseBottomSheet> createState() =>
      _UploadLicenseBottomSheetState();
}

class _UploadLicenseBottomSheetState extends State<UploadLicenseBottomSheet> {
  final GlobalKey<FormState> amountToSaveKey = GlobalKey();
  final amountToSaveController = TextEditingController();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    void chooseImage() async {
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            imageFile = File(image.path);
            idImageBytes.value = imageFile!.readAsBytesSync();
            context.read<ProfileCubit>().uploadID(
                context: context, imagePath: base64Encode(idImageBytes.value));
          });
        }
      } catch (_) {}
    }

    return ValueListenableBuilder(
        valueListenable: isIDUploaded,
        builder: (context, isUploadSuccessful, child) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Take a photo of your National Identification '
                              'Card or Voter’s card',
                              style: GlobalTextStyles.blueMediumTextB(
                                  context: context, fontSize: 20)),
                          const SizedBox(height: 20),
                          Text(
                              'Pleas make sure that the names on the ID Card '
                              'are correct for proper verification sake',
                              style: GlobalTextStyles.regularText(
                                  context: context, fontSize: 14)),
                          const SizedBox(height: 40),
                          Center(
                            child: InkWell(
                              onTap: () => chooseImage(),
                              child: Stack(clipBehavior: Clip.none, children: [
                                ClipRRect(
                                    child: idImageBytes.value.isEmpty
                                        ? Container(
                                            width: double.infinity,
                                            height: 250,
                                            decoration: BoxDecoration(
                                                color: GlobalColors.ashWhite,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            alignment: Alignment.center,
                                            child: const Text('Tap to upload',
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 250,
                                            decoration: BoxDecoration(
                                                color: GlobalColors.ashWhite,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.memory(
                                                base64Decode(base64Encode(idImageBytes.value)),
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                          )),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 60),
                          GlobalButton(
                              buttonText: 'Upload Photo',
                              onTap: () {
                                if (idImageBytes.value.isNotEmpty) {
                                  context.read<ProfileCubit>().uploadID(
                                      context: context,
                                      imagePath:
                                          base64Encode(idImageBytes.value));
                                }
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
