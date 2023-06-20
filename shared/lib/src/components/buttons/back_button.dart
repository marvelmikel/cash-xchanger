import 'package:core/core.dart';
import 'package:flutter/material.dart';


class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key, this.backButtonText = 'Account info'})
      : super(key: key);

  final String backButtonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => Navigator.pop(context),
              child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 40,
                  width: 40,
                  child: Icon(Icons.arrow_back_ios,
                      color: GlobalColors.globalWhite))),
          const SizedBox(width: 30),
          Text(
            backButtonText,
            style: GlobalTextStyles.regularTextWhite(
                context: context, fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class BlackBackButtonWidget extends StatelessWidget {
  const BlackBackButtonWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.globalWhite,
      child: Padding(
        padding:
        const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => Navigator.pop(context),
                child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 40,
                    width: 40,
                    child: Icon(Icons.arrow_back_ios,
                        color: GlobalColors.primaryBlack))),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: GlobalTextStyles.regularMediumW(
                      context: context, fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class ProfileBackButtonWidget extends StatelessWidget {
  const ProfileBackButtonWidget(
      {Key? key, required this.text, this.isImageVisible = true})
      : super(key: key);

  final String text;
  final bool isImageVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.globalWhite,
      child: Padding(
        padding:
        const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => Navigator.pop(context),
                child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 40,
                    width: 40,
                    child: Icon(Icons.arrow_back_ios,
                        color: GlobalColors.primaryBlack))),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: GlobalTextStyles.regularMediumH(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
