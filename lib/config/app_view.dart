import 'package:flutter/material.dart';

import '../routing/routing.dart';
import '../routing/routing_path.dart';

class MusixAppView extends StatelessWidget {
  const MusixAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutingPath.home,
      onGenerateRoute: routeController,
    );
  }
}
