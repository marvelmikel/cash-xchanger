import 'package:cash_xchanger/database/models/schedule_model/schedule_model.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduledCardsWidget extends StatelessWidget {
  const ScheduledCardsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        decoration: BoxDecoration(
            color: GlobalColors.globalWhite,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              children: [
                Text('Time',
                    style: GlobalTextStyles.regularText(
                        context: context, alpha: 70)),
                const SizedBox(width: 50),
                Text('Cash requests',
                    style: GlobalTextStyles.regularText(
                        context: context, alpha: 70)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 85,
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: GlobalColors.materialPrimaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {},
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset('assets/images/no_card.svg',
                        height: 70),
                    const SizedBox(height: 10),
                    const Text('No recent schedules')
                  ],
                ),
              ),
            )
            // Expanded(
            //   child: MediaQuery.removePadding(
            //     context: context,
            //     removeTop: true,
            //     child: ListView.builder(
            //         itemCount: ScheduleModule.listOfSchedules.length,
            //         itemBuilder: (context, index) => ScheduleCardItem(
            //             scheduleModule: ScheduleModule.listOfSchedules[index])),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCardItem extends StatelessWidget {
  const ScheduleCardItem({Key? key, required this.scheduleModule})
      : super(key: key);

  final ScheduleModule scheduleModule;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              scheduleModule.timeA,
              style: GlobalTextStyles.blueMediumText(
                  context: context, fontSize: 18),
            ),
            Text(
              scheduleModule.timeB,
              style: GlobalTextStyles.grayMediumText(
                  context: context, fontSize: 14),
            ),
          ],
        ),
        SizedBox(width: 20),
        Container(
          height: 185,
          width: 0.5,
          color: GlobalColors.primaryBlack.withAlpha(50),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: GlobalColors.ashWhite,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheduleModule.price,
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 18),
                ),
                SizedBox(height: 2),
                Text(
                  'Type: ${scheduleModule.type} notes',
                  style: GlobalTextStyles.blueMediumText(
                      context: context, fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/250?image=9',
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      scheduleModule.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.blueMediumText(
                          context: context, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/location_pin.svg',
                        color: GlobalColors.primaryBlack),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        scheduleModule.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GlobalTextStyles.regularText(
                            context: context, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
