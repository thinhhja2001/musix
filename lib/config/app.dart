import 'package:flutter/material.dart';

import 'app_view.dart';

class MusixApp extends StatefulWidget {
  const MusixApp({super.key});

  @override
  State<MusixApp> createState() => _MusixAppState();
}

class _MusixAppState extends State<MusixApp> {
  @override
  Widget build(BuildContext context) {
    return const MusixAppView();
  }
}
