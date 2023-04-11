import 'dart:io';

class PostRegistryModel {
  String content;
  String name;
  File? file;
  File? thumbnail;

  PostRegistryModel({
    required this.content,
    required this.name,
    this.file,
    this.thumbnail,
  });
}
