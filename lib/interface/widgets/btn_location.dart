part of 'widgets.dart';

class BtnLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<MyLocationBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            final destino = locationBloc.state.ubicacion;
            mapBloc..moveCamera(destino!);
          },
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
