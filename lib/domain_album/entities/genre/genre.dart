import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String? id;
  final String? title;
  final String? alias;

  const Genre({
    this.id,
    this.title,
    this.alias,
  });

  Genre copyWith({
    String? id,
    String? title,
    String? alias,
  }) {
    return Genre(
      id: id ?? this.id,
      title: title ?? this.title,
      alias: alias ?? this.alias,
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        alias,
      ];

  @override
  bool? get stringify => true;
}
