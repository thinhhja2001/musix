import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/song.dart';
import 'package:musix/utils/colors.dart';

import '../widgets/customs/custom_bottom_navigation_bar.dart';

const double kButtonMarginTop = 16;
const double kEdgeInset = 52;
const TextStyle kDefaultTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
const TextStyle kDefaultTitleStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18);
const TextStyle kDefaultHintStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(48, 255, 255, 255));
const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 18.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);

const Widget verticalSliverPaddingTiny =
    SliverPadding(padding: EdgeInsets.only(top: 5.0));
const Widget verticalSliverPaddingSmall =
    SliverPadding(padding: EdgeInsets.only(top: 10.0));
const Widget verticalSliverPaddingRegular =
    SliverPadding(padding: EdgeInsets.only(top: 18.0));
const Widget verticalSliverPaddingMedium =
    SliverPadding(padding: EdgeInsets.only(top: 25.0));
const Widget verticalSliverPaddingLarge =
    SliverPadding(padding: EdgeInsets.only(top: 50.0));

List<String> fakeSongsData = [
  'ZZA07BED',
  'ZZ9AUFD7',
  'ZWZD0CIO',
  'ZWACDBZ6',
  'ZZ909ZEI'
];
Song songWithNoData = Song(
    id: '',
    name: '',
    audioUrl: 'no',
    lyricUrl: '',
    artistName: '',
    artistLink: '',
    thumbnailUrl:
        'https://2.bp.blogspot.com/-muVbmju-gkA/Vir94NirTeI/AAAAAAAAT9c/VoHzHZzQmR4/s1600/placeholder-image.jpg');
Album albumWithNoData = Album(
    id: '',
    songs: [],
    title: '',
    artistNames: '',
    artistLink: '',
    thumbnailUrl:
        'https://2.bp.blogspot.com/-muVbmju-gkA/Vir94NirTeI/AAAAAAAAT9c/VoHzHZzQmR4/s1600/placeholder-image.jpg');

const noImageUrl =
    "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg";

final fakeAlbumData = Album(
    id: 'vnvn',
    songs: [],
    title: 'Nice for what',
    artistNames: 'Mother John',
    artistLink: 'artistLink',
    thumbnailUrl: noImageUrl);
final fakeFavoriteArtists = [
  'Taylor Swift',
  'Hoàng Dũng',
  'Đen',
  'Hồ Hạ',
  'Thiều Bảo Trâm',
  'Sơn Tùng'
];

List<CustomBottomBarItem> bottomBarItems = [
  CustomBottomBarItem(
      icon: const Icon(Icons.star_outline),
      title: const Text("Billboard"),
      unselectedColor: Colors.white,
      selectedColor: Colors.black),
  CustomBottomBarItem(
      icon: const Icon(Icons.favorite_outline),
      title: const Text("Explore"),
      unselectedColor: Colors.white,
      selectedColor: Colors.black),
  CustomBottomBarItem(
      icon: const Icon(Icons.search_outlined),
      title: const Text("Search"),
      unselectedColor: Colors.white,
      selectedColor: Colors.black),
];
