import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mapas_app/themes/map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  //controlador del mapa
  late GoogleMapController _mapController;

  //Polylines
  Polyline _myRoute = new Polyline(
    polylineId: PolylineId('my_Route'),
    width: 4,
  );

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

      //*Camera focus*//
    } else if (event is OnPositionUpdate) {
      yield* this._onPositionUpdate(event);

      //*Hide/Show route*//
    } else if (event is OnHideRoute) {
      yield* this._onHideRoute(event);

      //*Follow-unfollow route location*//
    } else if (event is OnFollowLocation) {
      yield* this._onFollowLocation(event);
    }
  }

  //Center Back Camera Postion width current location.
  Stream<MapState> _onPositionUpdate(OnPositionUpdate event) async* {
    if (state.followLocation) {
      this.moveCamera(event.position);
    }
    List<LatLng> points = [...this._myRoute.points, event.position];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    //the polylines
    final currentPolylines = state.polylines;
    currentPolylines['myRoute'] = this._myRoute;
    yield state.copyWith(polylines: currentPolylines);
  }

  //Hide and show polyline current route
  Stream<MapState> _onHideRoute(OnHideRoute event) async* {
    print(state.drawRoute);
    if (!state.drawRoute) {
      this._myRoute =
          this._myRoute.copyWith(colorParam: Colors.lightBlueAccent);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['myRoute'] = this._myRoute;

    yield state.copyWith(
      drawRoute: !state.drawRoute,
      polylines: currentPolylines,
    );
  }

  //Follow - unfollow location route line.
  Stream<MapState> _onFollowLocation(OnFollowLocation event) async* {
    if (!state.followLocation) {
      // this.moveCamera(this._myRoute[this._myRoute.points.length. - 1]);
    }
    yield state.copyWith(followLocation: !state.followLocation);
  }
}
