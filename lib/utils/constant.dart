import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SocialLoginType { facebook, google }
enum CustomInputFieldType { text, password }
const double kButtonMarginTop = 16;
const double kEdgeInset = 52;
const TextStyle kDefaultTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
const TextStyle kDefaultTitleStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18);

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
