import 'package:musix/utils/utils.dart';

Map<String, Status> updateMapStatus({
  required Map<String, Status>? source,
  required List<String> keys,
  required List<Status> status,
}) {
  Map<String, Status> mapAdapter = {};
  for (int i = 0; i < keys.length; i++) {
    mapAdapter.addAll({keys[i]: status[i]});
  }
  final result = Map<String, Status>.from(source ?? {})..addAll(mapAdapter);
  return result;
}
