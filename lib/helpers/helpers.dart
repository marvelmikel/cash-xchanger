import 'dart:convert';
import 'dart:io';

import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CupertinoActivityIndicator(),
        Container(
          margin: const EdgeInsets.only(left: 7),
          child: const Text('Loading...'),
        ),
      ],
    ),
  );
  showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () async => false, child: alert);
    },
  );
}

bool isValidEmail(BuildContext context, String email) {
  bool emailValid = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\'
          r's@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.'
          r'[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
          r')+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  if (emailValid) {
    return true;
  } else {
    return false;
  }
}

extension FormValidator on GlobalKey<FormState> {
  bool get validate => formValidator(this);
}

bool formValidator(GlobalKey<FormState> globalKey) {
  return globalKey.currentState!.validate();
}

Widget profileImage({required BuildContext context}) {
  return BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) {
      return CircleAvatar(
          radius: 20,
          backgroundColor: GlobalColors.primaryGreen,
          child: state.profilePic == null
              ? Text(
                  state.profileModel?.userDetails.firstName[0].toUpperCase() ??
                      'J',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ))
              : ClipOval(
                  child: Image.memory(
                    base64Decode(state.profilePic!.userDetails.profilePic),
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ));
    },
  );
}

profileImageX({required BuildContext context, required String email}) {
  File? imageFile;

  void chooseImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFile = File(image.path);
        List<int> imageBytes = imageFile!.readAsBytesSync();
        context.read<ProfileCubit>().uploadImage(
            imageBytes: base64Encode(imageBytes), context: context);
      }
    } catch (_) {}
  }

  return BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: GlobalColors.ashWhite, shape: BoxShape.circle),
            child: CircleAvatar(
                radius: 50,
                backgroundColor: GlobalColors.purpleBlue,
                child: state.profilePic == null
                    ? Text(
                        state.profileModel!.userDetails.username[0]
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ))
                    : ClipOval(
                        child: Image.memory(
                          base64Decode(
                              state.profilePic!.userDetails.profilePic),
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      )),
          ),
          Positioned(
              left: 80,
              top: 10,
              child: GestureDetector(
                  onTap: () => chooseImage(),
                  child: SvgPicture.asset('assets/images/edit_icon.svg',
                      height: 36)))
        ],
      );
    },
  );
}

String formatFigures(double amount) {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  return '${myFormat.simpleCurrencySymbol('NGN')} '
      '${myFormat.format(amount)}';
}

String formatFiguresSeparator(double amount) {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  return myFormat.format(amount);
}
