import 'dart:convert';
import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared/shared.dart';

ValueNotifier<DocUpload> isIDUploaded = ValueNotifier<DocUpload>(DocUpload());
var base64ID = ValueNotifier<String?>(null);

var idImageBytes = ValueNotifier<List<int>>([]);

class UploadLicenseBottomSheet extends StatefulWidget {
  const UploadLicenseBottomSheet({Key? key, required this.file})
      : super(key: key);
  final Function(String) file;
  @override
  State<UploadLicenseBottomSheet> createState() =>
      _UploadLicenseBottomSheetState();
}

class _UploadLicenseBottomSheetState extends State<UploadLicenseBottomSheet> {
  final GlobalKey<FormState> amountToSaveKey = GlobalKey();
  final amountToSaveController = TextEditingController(); //

  File? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idImageBytes.value = [];
    isIDUploaded.value.docsUpload = null;
  }

  @override
  Widget build(BuildContext context) {
    void chooseImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            imageFile = File(image.path);
            widget.file(image.path.split('/').last);
          
            idImageBytes.value = imageFile!.readAsBytesSync();
            base64ID.value = base64Encode(idImageBytes.value);
            isIDUploaded.value.docsUpload = true;
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
                                                base64Decode(base64Encode(
                                                    idImageBytes.value)),
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
                              title: 'continue',
                              onPressed: () => Navigator.pop(context))
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

class DocUpload {
  bool? selfieUpload;
  bool? docsUpload;

  DocUpload({this.selfieUpload, this.docsUpload});
}
