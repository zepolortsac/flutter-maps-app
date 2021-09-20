part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnRadyMap extends MapEvent {}

class OnPositionUpdate extends MapEvent {
  final LatLng position;

  OnPositionUpdate(this.position);
}
