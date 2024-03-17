import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/locale/app_locale_key.dart';
import '../../../../helpers/utils/date_methods.dart';
import '../../../../helpers/utils/navigator_methods.dart';
import '../../../custom_widgets/buttons/custom_button.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../../../custom_widgets/validation/validation_mixin.dart';
import '../controller/event_controller.dart';
import '../model/event_model.dart';
import '../widget/map_widget.dart';

class SaveEventArgs {
  final EventModel? event;
  final VoidCallback? onBack;

  SaveEventArgs({
    required this.event,
    this.onBack,
  });
}

class SaveEventScreen extends StatefulWidget {
  final SaveEventArgs args;
  const SaveEventScreen({super.key, required this.args});

  static const String routeName = 'SaveEventScreen';

  @override
  State<SaveEventScreen> createState() => _SaveEventScreenState();
}

class _SaveEventScreenState extends State<SaveEventScreen>
    with ValidationMixin {
  LatLng? _eventLocation;
  final _eventTypeEC = TextEditingController();
  final _dateTimeEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  final _locationEC = TextEditingController();
  DateTime? _date;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.args.event != null) {
      _eventLocation = LatLng(widget.args.event!.lat!, widget.args.event!.lng!);
      _date = DateTime.tryParse(widget.args.event!.date!);
      _eventTypeEC.text = widget.args.event?.eventType ?? "";
      _descriptionEC.text = widget.args.event?.description ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _locationEC.text = _eventLocation != null ? "Selected" : "";
    _dateTimeEC.text = _date != null
        ? DateMethods.formatToFullData(_date?.toIso8601String())
        : "";

    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          title: Text(
            tr(AppLocaleKey.addEvent),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  controller: _eventTypeEC,
                  title: tr(AppLocaleKey.eventType),
                  validator: validateEmptyField,
                ),
                const Gap(15),
                CustomFormField(
                  controller: _dateTimeEC,
                  title: tr(AppLocaleKey.dateTime),
                  readOnly: true,
                  onTap: () {
                    DateMethods.pickDate(
                      context,
                      firstDate: DateTime.now(),
                      initialDate: _date ?? DateTime.now(),
                      onSuccess: (v) {
                        DateMethods.pickTime(
                          context,
                          initialDate: _date ?? DateTime.now(),
                          onSuccess: (t) {
                            setState(() {
                              _date = DateTime(
                                  v.year, v.month, v.day, t.hour, t.minute);
                            });
                          },
                        );
                      },
                    );
                  },
                  validator: validateEmptyField,
                ),
                const Gap(15),
                CustomFormField(
                  controller: _descriptionEC,
                  title: tr(AppLocaleKey.description),
                  validator: validateEmptyField,
                ),
                const Gap(15),
                CustomFormField(
                  controller: _locationEC,
                  title: tr(AppLocaleKey.location),
                  validator: validateEmptyField,
                  readOnly: true,
                  onTap: () {
                    NavigatorMethods.showAppDialog(
                      context,
                      MapWidget(
                        eventLocation: _eventLocation,
                        onChanged: (v) {
                          setState(() {
                            _eventLocation = v;
                          });
                        },
                      ),
                    );
                  },
                ),
                const Gap(20),
                CustomButton(
                  text: tr(AppLocaleKey.save),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.args.event != null
                          ? context.read<EventController>().editEvent(
                                event: widget.args.event!,
                                eventType: _eventTypeEC.text,
                                date: _date?.toIso8601String() ?? "",
                                description: _descriptionEC.text,
                                lat: _eventLocation?.latitude ?? 0.0,
                                lng: _eventLocation?.longitude ?? 0.0,
                                onSuccess: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              )
                          : context.read<EventController>().addEvent(
                                eventType: _eventTypeEC.text,
                                date: _date?.toIso8601String() ?? "",
                                description: _descriptionEC.text,
                                lat: _eventLocation?.latitude ?? 0.0,
                                lng: _eventLocation?.longitude ?? 0.0,
                                onSuccess: () {
                                  Navigator.pop(context);
                                },
                              );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
