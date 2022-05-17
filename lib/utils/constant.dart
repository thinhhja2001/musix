import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';

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
  'ZW6EOWE9',
  'ZWZD0CIO',
  'ZWZ99DDO',
  'ZW67D67A'
];

const durationInfinity = Duration(days: 365);

const noImageUrl =
    "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg";

final fakeAlbumData = Album(
    id: 'vnvn',
    songs: [],
    title: 'Nice for what',
    artistNames: 'Mother John',
    artistLink: 'artistLink',
    thumbnailUrl: noImageUrl);
