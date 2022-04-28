
import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';

class InfoCard extends StatelessWidget {
  final String infoType;
  final String info;
  const InfoCard(this.infoType, this.info, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(infoType,style: TextStyle(color: Colors.white,fontSize: 15),)),
        Expanded(child: Align(
         alignment: Alignment.centerRight ,child: Text(info,style: TextStyle(color: kPrimaryColor,fontSize: 15)))),
      ],
    );
  }
}