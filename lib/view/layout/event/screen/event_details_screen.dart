import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/locale/app_locale_key.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/app_text_style.dart';
import '../../../../helpers/utils/common_methods.dart';
import '../../../../helpers/utils/date_methods.dart';
import '../../../../helpers/utils/navigator_methods.dart';
import '../../../custom_widgets/buttons/custom_button.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../controller/event_controller.dart';
import '../model/event_model.dart';
import 'save_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventModel event;
  const EventDetailsScreen({super.key, required this.event});
  static const String routeName = 'EventDetailsScreen';

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 13,
  );
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final List<Marker> _markers = <Marker>[];
  @override
  void initState() {
    if (widget.event.lat != null && widget.event.lng != null) {
      _setLocation(LatLng(widget.event.lat!, widget.event.lng!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          title: Text(
            tr(AppLocaleKey.eventDetails),
          ),
          actions: [
            _firebaseAuth.currentUser?.email == widget.event.email
                ? SizedBox(
                    width: 100,
                    child: Center(
                      child: Row(
                        children: [
                          CustomButton(
                            width: 35,
                            height: 35,
                            color: AppColor.greenColor(context),
                            style: AppTextStyle.text14B(
                              context,
                              color: AppColor.buttonTextColor(context),
                            ),
                            onPressed: () {
                              NavigatorMethods.pushNamed(
                                context,
                                SaveEventScreen.routeName,
                                arguments: SaveEventArgs(
                                  event: widget.event,
                                ),
                              );
                            },
                            child: Icon(
                              Icons.edit,
                              color: AppColor.buttonTextColor(context),
                            ),
                          ),
                          const Gap(10),
                          CustomButton(
                            width: 35,
                            height: 35,
                            style: AppTextStyle.text14B(
                              context,
                              color: AppColor.buttonTextColor(context),
                            ),
                            onPressed: () {
                              CommonMethods.showChooseDialog(context,
                                  message: 'Do you want to delete ?',
                                  onPressed: () {
                                Navigator.pop(context);
                                context.read<EventController>().deleteEvent(
                                    event: widget.event,
                                    onSuccess: () {
                                      Navigator.pop(context);
                                    });
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: AppColor.buttonTextColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    width: 100,
                    child: Center(
                      child: CustomButton(
                        text: widget.event.audience?.firstWhereOrNull(
                                    (element) =>
                                        element.id ==
                                        _firebaseAuth.currentUser?.uid) !=
                                null
                            ? 'Un Follow'
                            : 'Follow',
                        width: 80,
                        height: 35,
                        style: AppTextStyle.text14B(
                          context,
                          color: AppColor.buttonTextColor(context),
                        ),
                        onPressed: () {
                          widget.event.audience?.firstWhereOrNull((element) =>
                                      element.id ==
                                      _firebaseAuth.currentUser?.uid) !=
                                  null
                              ? context
                                  .read<EventController>()
                                  .removeAudience(event: widget.event)
                                  .then((value) => setState(() {}))
                              : context
                                  .read<EventController>()
                                  .addAudience(event: widget.event)
                                  .then((value) => setState(() {}));
                        },
                      ),
                    ),
                  )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr(AppLocaleKey.eventType),
                style: AppTextStyle.text16B(context),
              ),
              const Gap(10),
              Text(
                widget.event.eventType ?? "",
                style: AppTextStyle.text14B(
                  context,
                  color: AppColor.lightTextColor(context),
                ),
                textAlign: TextAlign.justify,
              ),
              const Gap(15),
              Text(
                tr(AppLocaleKey.dateTime),
                style: AppTextStyle.text16B(context),
              ),
              const Gap(10),
              Text(
                DateMethods.formatToFullData(widget.event.date),
                style: AppTextStyle.text14B(
                  context,
                  color: AppColor.lightTextColor(context),
                ),
                textAlign: TextAlign.justify,
              ),
              const Gap(15),
              Text(
                tr(AppLocaleKey.description),
                style: AppTextStyle.text16B(context),
              ),
              const Gap(10),
              Text(
                widget.event.description ?? "",
                style: AppTextStyle.text14B(
                  context,
                  color: AppColor.lightTextColor(context),
                ),
                textAlign: TextAlign.justify,
              ),
              const Gap(15),
              Text(
                tr(AppLocaleKey.location),
                style: AppTextStyle.text16B(context),
              ),
              const Gap(10),
              Container(
                width: double.infinity,
                height: 250,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.offWhiteColor(context),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(_markers),
                  initialCameraPosition: _cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              const Gap(15),
              Text(
                'Audiences',
                style: AppTextStyle.text16B(context),
              ),
              const Gap(10),
              ...List.generate(
                  widget.event.audience?.length ?? 0,
                  (index) => Column(
                        children: [
                          Text(
                            widget.event.audience?[index].email ?? "",
                            style: AppTextStyle.text14B(
                              context,
                              color: AppColor.lightTextColor(context),
                            ),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setLocation(LatLng value) async {
    _markers.clear();
    setState(() {});
    _markers.add(
      Marker(
        markerId: const MarkerId('location'),
        position: value,
      ),
    );
    setState(() {});
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: value,
          zoom: 13,
        ),
      ),
    );
    setState(() {});
  }
}
