import 'package:equatable/equatable.dart';
import 'package:musix/domain_global/entities/entities.dart';

import '../../../../utils/utils.dart';

class HomeMusicState extends Equatable {
  final Map<String, Status>? status;
  final HomeMusic? homeMusic;

  const HomeMusicState({
    this.status,
    this.homeMusic,
  });

  HomeMusicState copyWith({
    Map<String, Status>? status,
    HomeMusic? homeMusic,
  }) {
    return HomeMusicState(
      status: status,
      homeMusic: homeMusic,
    );
  }

  @override
  List<Object?> get props => [
        status,
        homeMusic,
      ];

  @override
  bool? get stringify => true;
}
