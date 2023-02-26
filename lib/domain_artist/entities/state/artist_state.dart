import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../entities.dart';

class ArtistState extends Equatable {
  final Map<String, Status>? status;
  final Artist? info;

  const ArtistState({
    this.status,
    this.info,
  });

  ArtistState copyWith({
    Map<String, Status>? status,
    Artist? info,
  }) {
    return ArtistState(
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
