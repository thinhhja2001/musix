import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/app.dart';

import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  boostrap();
}

void boostrap() {
  final debugLogger = DebugLogger();
  FlutterError.onError = (details) {
    debugLogger.log(details.exceptionAsString(), details.stack);
  };

  Bloc.observer = AppObserver();

  runZonedGuarded(
    () => runApp(
      const MusixApp(),
    ),
    (error, stackTrace) {
      debugLogger.log(error.toString());
    },
  );
}
