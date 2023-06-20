import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       elevation: 0,
        backgroundColor: Colors.white,
        title:  Text('Promotions',style: GlobalTextStyles.regularMediumH(fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => Navigator.pop(context),
            child: Container(
                margin: const EdgeInsets.only(left: 5),
                height: 40,
                width: 40,
                child: Icon(Icons.arrow_back_ios,
                    color: GlobalColors.primaryBlack))),
        actions: [
          MenuFiller(
            icon: Icons.menu,
            onClick: () {},
            color: GlobalColors.lightGreen,
            bgColor: Colors.transparent,
            size: 30,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            'No Promotions Yet',
            style: GlobalTextStyles.boldText(context: context, fontSize: 16)
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
              'Promo codes are not available at the moment. \nCheck back later',
              textAlign: TextAlign.center,
              style: GlobalTextStyles.boldText(context: context, fontSize: 16)
                  .copyWith(
                fontWeight: FontWeight.w500,
              )),
          SizedBox(
            height: 5.h,
          ),
          Divider(
            height: 1,
            color: GlobalColors.primaryGreen,
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Text(
                'No Promotions Yet',
                style: GlobalTextStyles.boldText(context: context, fontSize: 16)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          GlobalButton(
            title: "Copy link",
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
