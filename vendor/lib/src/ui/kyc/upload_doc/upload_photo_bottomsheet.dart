import 'dart:convert';
import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/shared.dart';
import 'package:vendor/src/ui/kyc/upload_doc/upload_id.dart';

var imageUploader = ValueNotifier(false);
var baseImage = ValueNotifier<String?>(null);
var base64Image = ValueNotifier<String?>(null);
var imageBytes = ValueNotifier<XFile?>(null);

class UploadPhotoBottomSheet extends StatefulWidget {
  const UploadPhotoBottomSheet({Key? key, required this.file})
      : super(key: key);

final Function(String) file;
  @override
  State<UploadPhotoBottomSheet> createState() => _UploadPhotoBottomSheetState();
}

class _UploadPhotoBottomSheetState extends State<UploadPhotoBottomSheet> {
  final GlobalKey<FormState> amountToSaveKey = GlobalKey();
  final amountToSaveController = TextEditingController();

  XFile? imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baseImage.value = null;
    isIDUploaded.value.selfieUpload = null;
  }

  @override
  Widget build(BuildContext context) {
    void chooseImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (image != null) {
          setState(() async {
            imageFile = XFile(image.path);
            baseImage.value = imageFile!.path;
            imageUploader.value = true;
            List<int> imageBytes = await image.readAsBytes();
            base64Image.value = base64Encode(imageBytes);
            isIDUploaded.value.selfieUpload = true;
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
                              child: ValueListenableBuilder(
                            valueListenable: baseImage,
                            builder: (context, value, child) => value == null
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
                                      child: SizedBox(
                                          height: 250,
                                          width: 250,
                                          child:
                                              Image.file(File(baseImage.value!))


                                          ),
                                    ),
                                  ),
                          )),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 60),
                    GlobalButton(
                        title: 'Continue',
                        onPressed: () => Navigator.pop(context))
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
