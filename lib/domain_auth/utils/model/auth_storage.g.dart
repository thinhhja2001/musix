// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthStorageAdapter extends TypeAdapter<AuthStorage> {
  @override
  final int typeId = 0;

  @override
  AuthStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthStorage()
      .._token = fields[0] as String
      .._username = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, AuthStorage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._token)
      ..writeByte(1)
      ..write(obj._username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
