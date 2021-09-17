import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapas_app/helper/helpers.dart';
import 'package:mapas_app/interface/screens/access_pgs_screen.dart';
import 'package:mapas_app/interface/screens/map_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print('==========> $state');
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navegarMapaFadein(context, MapScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    //PermissionGPS
    final accessGps = await Permission.location.isGranted;
    //GPS esta activo
    final gpsActive = await Geolocator.isLocationServiceEnabled();

    if (accessGps && gpsActive) {
      Navigator.pushReplacement(
          context, navegarMapaFadein(context, MapScreen()));
    } else if (!accessGps) {
      Navigator.pushReplacement(
          context, navegarMapaFadein(context, AccessGpsScreen()));
      return 'GPS Access is necesary';
    } else if (!gpsActive) {
      return 'Turn On GPS';
    }
  }
}
