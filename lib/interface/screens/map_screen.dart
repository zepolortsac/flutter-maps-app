import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/my_location/my_location_bloc.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    BlocProvider.of<MyLocationBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MyLocationBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: (_, state) => createMap(state),
      ),
    );
  }

  Widget createMap(MyLocationState state) {
    if (!state.existeUbicacion) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.redAccent,
              strokeWidth: 2.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text('Finding Location ...'),
          ],
        ),
      );
    } else {
      final initialCamaraPosition = new CameraPosition(
          target: LatLng(state.ubicacion!.latitude, state.ubicacion!.longitude),
          zoom: 14.0);
      return GoogleMap(
        initialCameraPosition: initialCamaraPosition,
        mapType: MapType.terrain,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        trafficEnabled: true,
      );
    }
  }
}
