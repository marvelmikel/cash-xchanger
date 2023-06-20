import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../shared.dart';

class NavMenuItem extends StatelessWidget {
  const NavMenuItem({
    Key? key,
    required this.menuTitle,
    required this.menuSubTitle,
    required this.menuImage,
    required this.onTap,
  }) : super(key: key);

  final String menuTitle, menuSubTitle, menuImage;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/$menuImage', height: 3.5.h),
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuTitle,
                      style:
                          GlobalTextStyles.regularTextWhite(context: context),
                    ),
                    Text(
                      menuSubTitle,
                      style: GlobalTextStyles.regularTextWashedWhite(
                          context: context, fontSize: 9.sp),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.5.h),
            Divider(
              height: 0.1,
              color: GlobalColors.washedWhite.withAlpha(100),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends ConsumerWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(profileViewModelProviderV1);
    return CircleAvatar(
        radius: 20,
        backgroundColor: GlobalColors.primaryGreen,
        child: model.currentUser.selfie == null
            ? Text(model.currentUser.fullName?[0].toUpperCase() ?? 'J',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ))
            : ClipOval(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageUrl: model.currentUser.selfie!),
                ),
              ));
  }
}


class ProfileImageX extends ConsumerWidget{
  const ProfileImageX({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileViewModelProviderV1);
    XFile? imageFile;
    void chooseImage() async {
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          imageFile = XFile(image.path);

              state.uploadImage(imageFile: imageFile!);
        }
      } catch (_) {}
    }
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
              child: state.currentUser.selfie == null
                  ? Text(state.currentUser.fullName![0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ))
                  : ClipOval(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: state.currentUser.selfie!,
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
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
  }


}

