part of 'widgets.dart';

class BtnMyRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              onPressed: () {
                mapBloc.add(OnHideRoute());
              },
              icon: Icon(
                mapBloc.state.drawRoute
                    ? Icons.more_horiz_outlined
                    : Icons.more_vert_outlined,
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}
