import 'dart:io';

class PostRegistryModel {
  String content;
  File? file;
  File? thumbnail;

  PostRegistryModel({
    required this.content,
    this.file,
    this.thumbnail,
  });
}
