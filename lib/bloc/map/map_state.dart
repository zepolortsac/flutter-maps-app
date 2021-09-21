part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool drawRoute;
  final bool followLocation;
  // final LaLng centralLocation;

  //Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.readyMap = false,
    this.drawRoute = true,
    this.followLocation = true,
    Map<String, Polyline>? polylines,
  }) : this.polylines = polylines ?? Map();

  MapState copyWith({
    bool? readyMap,
    bool? drawRoute,
    bool? followLocation,
    Map<String, Polyline>? polylines,
  }) =>
      new MapState(
        readyMap: readyMap ?? this.readyMap,
        drawRoute: drawRoute ?? this.drawRoute,
        polylines: polylines ?? this.polylines,
        followLocation: followLocation ?? this.followLocation,
      );
}
