
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class MenuFiller extends StatelessWidget {
  const MenuFiller(
      {Key? key,
      required this.icon,
      required this.onClick,
      required this.bgColor,
      this.color,
      this.size})
      : super(key: key);
  final IconData icon;
  final Function()? onClick;
  final Color? color;
  final Color? bgColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 5.5.h,
        height: 5.h,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}



class MenuBar extends ConsumerWidget {
  const MenuBar(
      {Key? key, this.nameLabel, this.leadingMsg, this.isWhiteBg = false, required this.scafoldKey})
      : super(key: key);
  final GlobalKey<ScaffoldState> scafoldKey;
  final String? nameLabel;
  final String? leadingMsg;
  final bool isWhiteBg;

  @override
  Widget build(BuildContext context, ref) {

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text('Welcome ${nameLabel ?? 'John'}',
                  style: !isWhiteBg
                      ? GlobalTextStyles.regularMediumWhiteH(
                      context: context, fontSize: 15.5.sp)
                      : GlobalTextStyles.regularMediumH(fontSize: 15.5.sp)),
              Text(leadingMsg!,
                  style: !isWhiteBg
                      ? GlobalTextStyles.regularTextWhite(
                      context: context, fontSize: 11.3.sp)
                      : GlobalTextStyles.regularText(
                      context: context, fontSize: 11.3.sp)),
            ],
          ),
          MenuFiller(
            icon: Icons.menu,
            onClick: () => scafoldKey.currentState!.openDrawer(),
            color: GlobalColors.lightGreen,
            bgColor: Colors.transparent,
            size: 30,
          ),
          // InkWell(
          //   onTap: () => ,
          //   borderRadius: BorderRadius.circular(10),
          //   child: Icon(
          //    ,
          //     size: 30,
          //     color:,
          //   ),
          // ),
        ],
      ),
    );
  }
}


