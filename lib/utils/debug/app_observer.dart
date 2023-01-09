import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils.dart';

class AppObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    DebugLogger debugLogger = DebugLogger();
    debugLogger.logBLoc('${bloc.runtimeType} $change');
  }
}
