import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:symstax/helpers/utils/date_methods.dart';
import 'package:symstax/helpers/utils/navigator_methods.dart';
import 'package:symstax/view/layout/event/model/event_model.dart';
import 'package:symstax/view/layout/event/screen/event_details_screen.dart';

import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/app_text_style.dart';

class EventWidget extends StatelessWidget {
  final EventModel event;
  const EventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(
          context,
          EventDetailsScreen.routeName,
          arguments: event,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.offWhiteColor(context),
          border: Border.all(color: AppColor.borderColor(context)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.eventType ?? "",
              style: AppTextStyle.text16B(context),
            ),
            const Gap(10),
            Text(
              event.email ?? "",
              style: AppTextStyle.text14B(context),
            ),
            const Gap(10),
            Text(
              DateMethods.formatToFullData(event.createdAt),
              style: AppTextStyle.text12R(context),
            )
          ],
        ),
      ),
    );
  }
}
