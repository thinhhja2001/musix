import 'package:equatable/equatable.dart';
import 'package:musix/utils/utils.dart';

import '../entities.dart';

class SocialSearchState extends Equatable {
  final Map<String, Status>? status;
  final SocialSearchValue? values;
  final String? search;
  final ResponseException? error;

  const SocialSearchState({
    this.status,
    this.search,
    this.values,
    this.error,
  });

  SocialSearchState copyWith({
    Map<String, Status>? status,
    SocialSearchValue? values,
    String? search,
    ResponseException? error,
  }) {
    return SocialSearchState(
      status: status ?? this.status,
      values: values ?? this.values,
      search: search ?? this.search,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        values,
        search,
        error,
      ];

  @override
  bool? get stringify => true;
}
