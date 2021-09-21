part of 'widgets.dart';

class BtnFollorLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    // final locationBloc = BlocProvider.of<MyLocationBloc>(context);

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              onPressed: () {
                mapBloc.add(OnFollowLocation());
              },
              icon: Icon(
                mapBloc.state.followLocation
                    ? Icons.directions_run
                    : Icons.accessibility_new_sharp,
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}
