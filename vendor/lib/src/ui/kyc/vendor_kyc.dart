import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_string/random_string.dart';
import 'package:shared/shared.dart';

import 'kyc_view_model.dart';
import 'upload_doc/upload_id.dart';
import 'upload_doc/upload_photo_bottomsheet.dart';

// ignore: must_be_immutable
class VendorWelcomeScreen extends ConsumerStatefulWidget {
  const VendorWelcomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VendorWelcomeScreen createState() => _VendorWelcomeScreen();
}

class _VendorWelcomeScreen extends ConsumerState<VendorWelcomeScreen> {
  String idType = '';
  String labelVal = 'Choose ID Type';
  String idFileName = '';
  String selfieFileName = '';
  final String tag = randomAlpha(10);
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(profileViewModelProviderV1);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: isIDUploaded,
              builder: (context, DocUpload value, child) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: GlobalSizes.topSpacing(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome ${controller.currentUser.fullName}',
                        // 'Welcome $userName',
                        style: GlobalTextStyles.boldText(
                            context: context, fontSize: 25),
                      ),
                      SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                      Center(
                          child: SvgPicture.asset(
                              'assets/images/timeline_three.svg')),
                      const SizedBox(height: 60),
                      Text(
                        'Required steps',
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.blueMediumText(
                            context: context, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Here\'s what you need to do to set up your account',
                        style: GlobalTextStyles.regularText(
                            context: context, fontSize: 16),
                      ),
                      const SizedBox(height: 60),
                      GestureDetector(
                        onTap: () async => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => UploadPhotoBottomSheet(
                                  file: (p0) {
                                    setState(() {
                                      selfieFileName = p0;
                                    });
                                  },
                                )),
                        // getItInstance<VendorKycCubit>()
                        //     .openSelfieModal("11", tag);

                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/gallery_image.svg',
                                          height: 30),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vendor’s photo',
                                            style: GlobalTextStyles
                                                .blueMediumTextB(
                                                    context: context,
                                                    fontSize: 18),
                                          ),
                                          Text(
                                            'Recommended next step',
                                            style: GlobalTextStyles.regularText(
                                                context: context, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      color: GlobalColors.primaryBlack
                                          .withAlpha(50))
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => UploadLicenseBottomSheet(
                                  file: ((p0) {
                                    setState(() {
                                      idFileName = p0;
                                    });
                                  }),
                                )),
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/file_image.svg',
                                          height: 30),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vendor’s ID/License',
                                            style: GlobalTextStyles
                                                .blueMediumTextB(
                                                    context: context,
                                                    fontSize: 18),
                                          ),
                                          Text(
                                            'Get started',
                                            style: GlobalTextStyles.regularText(
                                                context: context, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      color: GlobalColors.primaryBlack
                                          .withAlpha(50))
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownInput(
                          //  hint: electricityBillsViewModel.packageLabel,
                          label: labelVal,
                          // value: idType,
                          onChanged: (val) {
                            setState(() {
                              idType = val.toString();
                              labelVal = val.toString().replaceAll('_', ' ');
                              print("this is the id Type $idType");
                            });
                          },
                          style: GlobalTextStyles.blueMediumTextB(
                              context: context, fontSize: 18),
                          options: [
                            InputItem('DRIVERS_LICENSE', 'DRIVERS LICENSE'),
                            InputItem('NATIONAL_ID', 'NATIONAL ID'),
                            InputItem('PASSPORT', 'PASSPORT'),
                            InputItem('VOTER_ID', 'VOTER ID'),
                          ]),
                      SizedBox(height: GlobalSizes.globalWidth(context, 0.19)),
                      GlobalButton(
                        title: 'Complete Signup',
                        isDisabled: value.docsUpload == null ||
                            value.selfieUpload == null ||
                            idType.isEmpty,
                        onPressed: () async {
                          if (idType.isEmpty) {
                            var snackBar = const SnackBar(
                                content: Text(
                                    'Kindly selected a Document type to proceed'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            if (value.docsUpload == true &&
                                value.selfieUpload == true) {
                              ref.read(kycViewModel).submitJob(
                                    documentType: idType,
                                    context: context,
                                  );
                            }
                          }
                        },
                      ),
                      SizedBox(height: GlobalSizes.globalWidth(context, 0.04))
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
