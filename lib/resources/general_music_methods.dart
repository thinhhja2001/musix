import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeneralMusicMethods {
  ///All favorite object include albums, songs, artists, videos

  static Stream<DocumentSnapshot> getAllFavoriteObject() {
    final currentUser = FirebaseAuth.instance.currentUser;
    final favorites = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('playlists')
        .doc('favorites')
        .snapshots();
    return favorites;
  }
}
