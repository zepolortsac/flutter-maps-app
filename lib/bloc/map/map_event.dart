part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnRadyMap extends MapEvent {}

class OnHideRoute extends MapEvent {}

class OnFollowLocation extends MapEvent {}

class OnMapMoved extends MapEvent {
  final LatLng centerMap;

  OnMapMoved(this.centerMap);
}

class OnPositionUpdate extends MapEvent {
  final LatLng position;

  OnPositionUpdate(this.position);
}
