import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:cash_xchanger/ui/global_widgets/global_gray_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'upload_doc/upload_id.dart';
import 'upload_doc/upload_photo_bottomsheet.dart';

class VendorWelcomeScreen extends StatelessWidget {
  const VendorWelcomeScreen({Key? key, required this.vendorData})
      : super(key: key);

  final List<dynamic> vendorData;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20, right: 20, top: GlobalSizes.topSpacing(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${vendorData[0]}',
                  // 'Welcome $userName',
                  style: GlobalTextStyles.blueBoldText(
                      context: context, fontSize: 25),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                Center(
                    child:
                        SvgPicture.asset('assets/images/timeline_three.svg')),
                const SizedBox(height: 60),
                Text(
                  'Required steps',
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  'Here\'s what you need to do to set up your account',
                  style: GlobalTextStyles.regularText(
                      context: context, fontSize: 16),
                ),
                SizedBox(height: 60),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          UploadPhotoBottomSheet(email: vendorData[1])),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/gallery_image.svg',
                                    height: 30),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vendor’s photo',
                                      style: GlobalTextStyles.blueMediumTextB(
                                          context: context, fontSize: 18),
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
                                color: GlobalColors.primaryBlack.withAlpha(50))
                          ],
                        ),
                        const SizedBox(height: 15),
                        Divider()
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          UploadLicenseBottomSheet(email: vendorData[1])),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/file_image.svg',
                                    height: 30),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vendor’s ID/License',
                                      style: GlobalTextStyles.blueMediumTextB(
                                          context: context, fontSize: 18),
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
                                color: GlobalColors.primaryBlack.withAlpha(50))
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Divider()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.19)),
                ValueListenableBuilder(
                    valueListenable: isIDUploaded,
                    builder: (context, bool value, child) {
                      return GlobalGrayButton(
                        buttonText: 'Launch CXapp',
                        isIDUpload: value,
                        onTap: () {
                          if (value) {
                            getItInstance<NavigationServiceImpl>()
                                .navigateTo(Routes.vendorDashboard);
                          }
                        },
                      );
                    }),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.04))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
