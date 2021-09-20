import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super(MyLocationState());

  void iniciarSeguimiento() {
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    ).listen((Position position) {
      final newLocation = new LatLng(position.latitude, position.longitude);
      print(position);
      add(OnLocationChanged(newLocation));
    });
  }

  void cancelarSeguimiento() {
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    ).listen((Position position) {
      // print(position);
    }).cancel();
  }

  @override
  Stream<MyLocationState> mapEventToState(MyLocationEvent event) async* {
    if (event is OnLocationChanged) {
      print(event);
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion,
      );
    }
  }
}
