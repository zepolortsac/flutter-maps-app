part of 'helpers.dart';

navegarMapaFadein(BuildContext context, Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => screen,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut),
        ),
      );
    },
  );
}
