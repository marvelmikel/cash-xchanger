import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_back_button.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'scheduled_card_widget.dart';

class ScheduledTransfers extends StatelessWidget {
  const ScheduledTransfers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavigationDrawer(),
      body: Column(
        children: [
          const ProfileBackButtonWidget(
              text: 'Request cash', isImageVisible: true),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                Text(
                  DateFormat('dd').format(DateTime.now()),
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 55),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('E').format(DateTime.now())),
                    Text(DateFormat('yMMMM').format(DateTime.now()))
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          const ScheduledCardsWidget()
        ],
      ),
    );
  }
}
