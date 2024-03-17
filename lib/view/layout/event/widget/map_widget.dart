import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../../helpers/locale/app_locale_key.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../../custom_widgets/buttons/custom_button.dart';

class MapWidget extends StatefulWidget {
  final LatLng? eventLocation;
  final void Function(LatLng?) onChanged;
  const MapWidget({super.key, required this.onChanged, this.eventLocation});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final List<Marker> _markers = <Marker>[];

  LatLng? _eventLocation;

  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 13,
  );

  @override
  void initState() {
    _eventLocation = widget.eventLocation;
    if (_eventLocation != null) {
      _setLocation(_eventLocation!);
    } else {
      _initial();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      elevation: 0,
      child: Column(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              color: AppColor.whiteColor(context),
              size: 40,
            ),
          ),
          const Gap(15),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      markers: Set<Marker>.of(_markers),
                      initialCameraPosition: _cameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onTap: (v) {
                        _setLocation(v);
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CustomButton(
                        width: 100,
                        text: tr(AppLocaleKey.save),
                        onPressed: () {
                          widget.onChanged.call(_eventLocation);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initial() async {
    final myLocation = await _getLocation();
    _setLocation(LatLng(
        myLocation?.latitude ?? 30.033333, myLocation?.longitude ?? 31.233334));
  }

  Future<LocationData?> _getLocation() async {
    Location location = Location();
    PermissionStatus permissionGranted;
    LocationData? locationData;
    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        locationData = await location.getLocation();
        return locationData;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        locationData = await location.getLocation();
        return locationData;
      }
    }
    locationData = await location.getLocation();
    return locationData;
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
    _eventLocation = value;
    setState(() {});
  }
}
