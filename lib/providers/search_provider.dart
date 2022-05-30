import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';

import 'package:provider/provider.dart';

class SearchProvider with ChangeNotifier {
  int _classify_index = 0;

  var _indexClicked = [true, false, false, false];

  bool _Loading = false;

  List<Map<String, dynamic>> _songList = List.empty(growable: true);
  List<Map<String, dynamic>> _artistList = List.empty(growable: true);
  List<Map<String, dynamic>> _videoList = List.empty(growable: true);
  List<Map<String, dynamic>> _albumList = List.empty(growable: true);

  int get classify_index => _classify_index;

  bool get Loading => _Loading;

  get indexClicked => _indexClicked;

  get songList => _songList;
  get artistList => _artistList;
  get videoList => _videoList;
  get albumList => _albumList;

  void IndexClick(int index) {
    _indexClicked[_classify_index] = false;
    _classify_index = index;
    _indexClicked[_classify_index] = true;
    notifyListeners();
  }

  String SearchCategoryType(int type) {
    switch (type) {
      case 1:
        return "Songs";
      case 2:
        return "Artists";
      default:
        return "Albums";
    }
  }

  Future<void> getSongByAll(String search) async {
    _Loading = true;
    notifyListeners();
    await ZingMP3API.getAllDataByName(search).then((value) {
      _songList = value['songs'];
      _artistList = value['artists'];
      _videoList = value['videos'];
      _albumList = value['albums'];

      _Loading = false;
      notifyListeners();
    });
  }
}
