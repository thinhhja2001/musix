import 'package:flutter/material.dart';
import 'package:musix/apis/song.dart';

enum SocialLoginType { facebook, google }
enum CustomInputFieldType { text, password }
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

List<Song> fakeSongsData = [
  Song(
      id: 'ZZ9IU6WA',
      name: 'Nàng Thơ',
      audioUrl:
          'https://vnso-zn-10-tf-mp3-s1-m-zmp3.zmdcdn.me/c18eaa80f3c11a9f43d0/2761020466868508166?authen=exp=1652740871~acl=/c18eaa80f3c11a9f43d0/*~hmac=3b36b9e769e5f83c5d63a91566ce064f&fs=MTY1MjU2ODA3MTk4MHx3ZWJWNHwxNzEdUngMjI1LjI0OC42Nw',
      lyricUrl:
          "https://static-zmp3.zmdcdn.me/lyrics/a/b/5/1/ab51ba63294631b958663a394379e362.lrc",
      artistName: 'Hoàng Dũng',
      artistLink: "/nghe-si/Nang-Tho-Hoang-Dung",
      thumbnailUrl:
          'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/e/6/7/e/e67ea0b93182adbf44c6a019591834df.jpg'),
  Song(
      id: 'ZW6EOWE9',
      name: 'In The End',
      audioUrl:
          'https://vnso-zn-15-tf-mp3-s1-m-zmp3.zmdcdn.me/ad72e5d09d9474ca2d85/4240633508708308556?authen=exp=1652757663~acl=/ad72e5d09d9474ca2d85/*~hmac=ad71aed8c6a49f41d19095c1b268ce57&fs=MTY1MjU4NDg2MzE2OXx3ZWJWNHwxMTMdUngMTYxLjY2LjEwMA',
      lyricUrl:
          "https://static-zmp3.zmdcdn.me/lyrics/1/b/2/4/1b2470b9b0d95941b3058612146171ad.lrc",
      artistName: 'Linkin Park',
      artistLink: "https://mp3.zing.vn/nghe-si/Linkin-Park",
      thumbnailUrl:
          'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/avatars/6/e/6e9263ba999c5b5647af63253b798d16_1495079133.jpg'),
  Song(
      id: 'ZZ9IU6WB',
      name: 'Nàng Thơ',
      audioUrl:
          'https://vnso-zn-10-tf-mp3-s1-m-zmp3.zmdcdn.me/c18eaa80f3c11a9f43d0/2761020466868508166?authen=exp=1652740871~acl=/c18eaa80f3c11a9f43d0/*~hmac=3b36b9e769e5f83c5d63a91566ce064f&fs=MTY1MjU2ODA3MTk4MHx3ZWJWNHwxNzEdUngMjI1LjI0OC42Nw',
      lyricUrl:
          "https://static-zmp3.zmdcdn.me/lyrics/a/b/5/1/ab51ba63294631b958663a394379e362.lrc",
      artistName: 'Hoàng Dũng',
      artistLink: "/nghe-si/Nang-Tho-Hoang-Dung",
      thumbnailUrl:
          'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/e/6/7/e/e67ea0b93182adbf44c6a019591834df.jpg'),
  Song(
      id: 'ZZ9IU6WD',
      name: 'Nàng Thơ',
      audioUrl:
          'https://vnso-zn-10-tf-mp3-s1-m-zmp3.zmdcdn.me/c18eaa80f3c11a9f43d0/2761020466868508166?authen=exp=1652740871~acl=/c18eaa80f3c11a9f43d0/*~hmac=3b36b9e769e5f83c5d63a91566ce064f&fs=MTY1MjU2ODA3MTk4MHx3ZWJWNHwxNzEdUngMjI1LjI0OC42Nw',
      lyricUrl:
          "https://static-zmp3.zmdcdn.me/lyrics/a/b/5/1/ab51ba63294631b958663a394379e362.lrc",
      artistName: 'Hoàng Dũng',
      artistLink: "/nghe-si/Nang-Tho-Hoang-Dung",
      thumbnailUrl:
          'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/e/6/7/e/e67ea0b93182adbf44c6a019591834df.jpg'),
  Song(
      id: 'ZZ9IU6WE',
      name: 'Nàng Thơ',
      audioUrl:
          'https://vnso-zn-10-tf-mp3-s1-m-zmp3.zmdcdn.me/c18eaa80f3c11a9f43d0/2761020466868508166?authen=exp=1652740871~acl=/c18eaa80f3c11a9f43d0/*~hmac=3b36b9e769e5f83c5d63a91566ce064f&fs=MTY1MjU2ODA3MTk4MHx3ZWJWNHwxNzEdUngMjI1LjI0OC42Nw',
      lyricUrl:
          "https://static-zmp3.zmdcdn.me/lyrics/a/b/5/1/ab51ba63294631b958663a394379e362.lrc",
      artistName: 'Hoàng Dũng',
      artistLink: "/nghe-si/Nang-Tho-Hoang-Dung",
      thumbnailUrl:
          'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/e/6/7/e/e67ea0b93182adbf44c6a019591834df.jpg')
];
