import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../helpers/utils/navigator_methods.dart';
import '../model/event_model.dart';

class EventController extends ChangeNotifier {
  final _eventCollection = FirebaseFirestore.instance.collection('events');
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>>? _eventsStream;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get eventsStream =>
      _eventsStream;

  void getEvents() {
    _eventsStream = _eventCollection.orderBy('id').snapshots();
  }

  Future<void> addEvent({
    required String eventType,
    required String date,
    required String description,
    required double lat,
    required double lng,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    final id =
        "${_firebaseAuth.currentUser?.email}${DateTime.now().microsecondsSinceEpoch}";
    final body = EventModel(
      audience: [],
      createdAt: DateTime.now().toIso8601String(),
      description: description,
      date: date,
      email: _firebaseAuth.currentUser?.email,
      eventType: eventType,
      id: id,
      lat: lat,
      lng: lng,
    );

    await _eventCollection.doc(id).set(body.toJson());

    NavigatorMethods.loadingOff();
    onSuccess.call();
  }

  Future<void> editEvent({
    required EventModel event,
    required String eventType,
    required String date,
    required String description,
    required double lat,
    required double lng,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    EventModel eventModel = event;
    eventModel.date = date;
    eventModel.eventType = eventType;
    eventModel.description = description;
    eventModel.lat = lat;
    eventModel.lng = lng;
    await _eventCollection.doc(event.id).update(eventModel.toJson());
    NavigatorMethods.loadingOff();

    onSuccess.call();
  }

  Future<void> addAudience({required EventModel event}) async {
    log('Add');
    NavigatorMethods.loading();
    EventModel eventModel = event;
    eventModel.audience?.add(
      Audience(
        email: _firebaseAuth.currentUser?.email,
        id: _firebaseAuth.currentUser?.uid,
      ),
    );
    await _eventCollection.doc(event.id).update(eventModel.toJson());
    NavigatorMethods.loadingOff();
  }

  Future<void> removeAudience({required EventModel event}) async {
    log('remove');
    NavigatorMethods.loading();
    EventModel eventModel = event;
    eventModel.audience?.removeWhere(
        (element) => element.id == _firebaseAuth.currentUser?.uid);
    await _eventCollection.doc(event.id).update(eventModel.toJson());
    NavigatorMethods.loadingOff();
  }

  Future<void> deleteEvent({
    required EventModel event,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();

    await _eventCollection.doc(event.id).delete();
    onSuccess.call();
    NavigatorMethods.loadingOff();
  }
}
