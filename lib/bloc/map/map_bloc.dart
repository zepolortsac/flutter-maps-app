import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mapas_app/themes/map_theme.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  late GoogleMapController _mapController;

  void initMap(GoogleMapController controller) {
    if (!state.readyMap) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(mapTheme));

      add(OnRadyMap());
    }
  }

  void moveCamera(LatLng destination) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnRadyMap) {
      yield state.copyWith(readyMap: true);
    }
  }
}
