part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool drawRoute;

  //Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.readyMap = false,
    this.drawRoute = true,
    Map<String, Polyline>? polylines,
  }) : this.polylines = polylines ?? Map();

  MapState copyWith({
    bool? readyMap,
    bool? drawRoute,
    Map<String, Polyline>? polylines,
  }) =>
      new MapState(
        readyMap: readyMap ?? this.readyMap,
        drawRoute: drawRoute ?? this.drawRoute,
        polylines: polylines ?? this.polylines,
      );
}
