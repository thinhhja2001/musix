import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../entities.dart';

class HubState extends Equatable {
  final Map<String, Status>? status;
  final Hub? info;

  const HubState({
    this.status,
    this.info,
  });

  HubState copyWith({
    Map<String, Status>? status,
    Hub? info,
  }) {
    return HubState(
      status: status ?? this.status,
      info: info ?? this.info,
    );
  }

  @override
  List<Object?> get props => [
        status,
        info,
      ];

  @override
  bool? get stringify => true;
}
