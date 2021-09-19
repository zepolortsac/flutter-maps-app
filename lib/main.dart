import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/bloc/my_location/my_location_bloc.dart';

import 'package:mapas_app/interface/screens/access_pgs_screen.dart';
import 'package:mapas_app/interface/screens/loading_screen.dart';
import 'package:mapas_app/interface/screens/map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MyLocationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingScreen(),
        routes: {
          'map': (_) => MapScreen(),
          'loading': (_) => LoadingScreen(),
          'acess_gps': (_) => AccessGpsScreen(),
        },
      ),
    );
  }
}
