import 'package:flutter/material.dart';

import '../routing/routing.dart';
import '../routing/routing_path.dart';

class MusixAppView extends StatelessWidget {
  final String path;
  const MusixAppView({
    Key? key,
    this.path = RoutingPath.signIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: path,
      onGenerateRoute: routeController,
    );
  }
}
