import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessGpsScreen extends StatefulWidget {
  @override
  _AccessGpsScreenState createState() => _AccessGpsScreenState();
}

class _AccessGpsScreenState extends State<AccessGpsScreen>
    with WidgetsBindingObserver {
  bool popup = false;
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
    if (state == AppLifecycleState.resumed && !popup) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('GPS required to use this App'),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              child: Text(
                'Request Access',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                popup = true;
                final status = await Permission.location.request();
                this.accessGPS(status);
                popup = false;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future accessGPS(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, 'loading');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
