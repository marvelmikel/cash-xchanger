import 'dart:convert';
import 'dart:io';

import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

var imageUploader = ValueNotifier(false);
var baseImage = ValueNotifier('');
var imageBytes = ValueNotifier<List<int>>([]);

class UploadPhotoBottomSheet extends StatefulWidget {
  const UploadPhotoBottomSheet({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<UploadPhotoBottomSheet> createState() => _UploadPhotoBottomSheetState();
}

class _UploadPhotoBottomSheetState extends State<UploadPhotoBottomSheet> {
  final GlobalKey<FormState> amountToSaveKey = GlobalKey();
  final amountToSaveController = TextEditingController();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    void chooseImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (image != null) {
          setState(() {
            imageFile = File(image.path);
             imageBytes.value = imageFile!.readAsBytesSync();
            baseImage.value = base64Encode(imageBytes.value);
            imageUploader.value = true;
            context.read<ProfileCubit>().uploadImage(
                imageBytes: base64Encode(imageBytes.value), context: context);
          });
        }
      } catch (_) {}
    }

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
                    Text('Take your profile photo',
                        style: GlobalTextStyles.blueMediumTextB(
                            context: context, fontSize: 20)),
                    const SizedBox(height: 20),
                    Text(
                        'Your profile photo helps people recognize you. Please'
                        ' note that once you submit your profile photo for'
                        ' review it cannot be changed',
                        style: GlobalTextStyles.regularText(
                            context: context, fontSize: 14)),
                    const SizedBox(height: 20),
                    Text(
                        '1. Face the camera directly with your eyes and mouth clearly visible',
                        style: GlobalTextStyles.regularText(
                            context: context, fontSize: 14)),
                    const SizedBox(height: 10),
                    Text(
                        '2. Make sure the photo is well lit, free of glare, and in focus',
                        style: GlobalTextStyles.regularText(
                            context: context, fontSize: 14)),
                    const SizedBox(height: 10),
                    Text('3. No photos of a photo, filters, or alterations',
                        style: GlobalTextStyles.regularText(
                            context: context, fontSize: 14)),
                    const SizedBox(height: 40),
                    Center(
                      child: InkWell(
                        onTap: () => chooseImage(),
                        child: Stack(clipBehavior: Clip.none, children: [
                          ClipRRect(
                              child:imageBytes.value.isEmpty
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 80, horizontal: 40),
                                      decoration: BoxDecoration(
                                          color: GlobalColors.ashWhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text('Tap to upload',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: GlobalColors.ashWhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          base64Decode(baseImage.value),
                                          fit: BoxFit.cover,
                                          height: 250,
                                          width: 250,
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
                          if (imageBytes.value.isNotEmpty) {
                            context.read<ProfileCubit>().uploadImage(
                                imageBytes: base64Encode(imageBytes.value), context: context);
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
  }
}
