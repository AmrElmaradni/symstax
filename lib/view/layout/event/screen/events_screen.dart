import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../helpers/utils/common_methods.dart';
import '../../../custom_widgets/custom_loading/custom_loading.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screen/login_screen.dart';
import '../controller/event_controller.dart';
import '../model/event_model.dart';

import '../../../../helpers/locale/app_locale_key.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/app_theme_controller.dart';
import '../../../../helpers/theme/theme_enum.dart';
import '../../../../helpers/utils/navigator_methods.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../widget/event_widget.dart';
import 'save_event_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  static const String routeName = 'EventsScreen';

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    context.read<EventController>().getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          title: Text(
            tr(AppLocaleKey.home),
          ),
          leading: IconButton(
            onPressed: () {
              CommonMethods.showChooseDialog(
                context,
                message: tr(AppLocaleKey.signOutQ),
                onPressed: () {
                  context.read<AuthController>().logout(
                    onSuccess: () {
                      NavigatorMethods.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                  );
                },
              );
            },
            icon: Icon(
              Icons.logout_rounded,
              color: AppColor.appBarTextColor(context),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (context.read<AppThemeController>().theme ==
                    ThemeEnum.light) {
                  context.read<AppThemeController>().theme = ThemeEnum.dark;
                } else {
                  context.read<AppThemeController>().theme = ThemeEnum.light;
                }
              },
              icon: Icon(
                context.read<AppThemeController>().theme == ThemeEnum.light
                    ? CupertinoIcons.moon_fill
                    : CupertinoIcons.sun_min_fill,
                color: AppColor.appBarTextColor(context),
              ),
            ),
          ],
        ),
        body: Consumer<EventController>(
          builder: (context, eventController, _) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: eventController.eventsStream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      List<EventModel> events = snapshot.data!.docs
                          .map((e) => EventModel.fromJson(e.data()))
                          .toList();
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        itemBuilder: (context, index) => EventWidget(
                          event: events[index],
                        ),
                        separatorBuilder: (context, index) => const Gap(15),
                        itemCount: events.length,
                      );
                    } else {
                      return Container();
                    }
                  default:
                    return const Center(child: CustomLoading());
                }
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.mainAppColor(context),
          heroTag: 'Save Event',
          onPressed: () {
            NavigatorMethods.pushNamed(
              context,
              SaveEventScreen.routeName,
              arguments: SaveEventArgs(
                event: null,
              ),
            );
          },
          child: Icon(
            Icons.add_rounded,
            color: AppColor.buttonTextColor(context),
          ),
        ),
      ),
    );
  }
}
