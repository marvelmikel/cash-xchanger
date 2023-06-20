
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

ValueNotifier userType = ValueNotifier('unselected');
ValueNotifier<String> userImage = ValueNotifier<String>('');

class UserCashWidget extends StatelessWidget {
  final String activeImage, inActiveImage, title, description;
  final String userRole;

  const UserCashWidget({
    Key? key,
    required this.activeImage,
    required this.inActiveImage,
    required this.title,
    required this.description,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userType,
        builder: (context, value, child) {
          return Expanded(
            child: GestureDetector(
              onTap: () => userType.value = userRole,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: value != userRole
                          ? GlobalColors.washedWhite
                          : GlobalColors.purpleBlue,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    value != userRole
                        ? SvgPicture.asset('assets/images/$inActiveImage')
                        : SvgPicture.asset('assets/images/$activeImage'),
                    SizedBox(height: GlobalSizes.globalHeight(context, 0.03)),
                    Text(
                      title,
                      style: value != userRole
                          ? GlobalTextStyles.boldText(
                              context: context, fontSize: 16)
                          : GlobalTextStyles.purpleBoldText(
                              context: context, fontSize: 16),
                    ),
                    SizedBox(height: GlobalSizes.globalHeight(context, 0.03)),
                    Text(description),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
