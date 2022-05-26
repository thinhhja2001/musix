import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';

class AlbumProvider extends ChangeNotifier {
  late Album currentAlbum;
  void setCurrentAlbum(Album newAlbum) {
    currentAlbum = newAlbum;
    print("da chay xong");
    // notifyListeners();
  }
}
