import 'package:equatable/equatable.dart';
import '../../entities.dart';

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
      status: status ?? this.status,
      homeMusic: homeMusic ?? this.homeMusic,
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
