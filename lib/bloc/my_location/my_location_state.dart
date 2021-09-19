part of 'my_location_bloc.dart';

@immutable
class MyLocationState {
  final bool siguiendo;
  final bool existeUbicacion;
  final LatLng? ubicacion;

  MyLocationState({
    this.siguiendo = true,
    this.existeUbicacion = false,
    this.ubicacion,
  });

  MyLocationState copyWith({
    bool? siguiendo,
    bool? existeUbicacion,
    LatLng? ubicacion,
  }) =>
      new MyLocationState(
        siguiendo: siguiendo ?? this.siguiendo,
        existeUbicacion: existeUbicacion ?? this.existeUbicacion,
        ubicacion: ubicacion ?? this.ubicacion,
      );
}
