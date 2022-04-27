import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';

class IconText extends StatelessWidget {
  const IconText({Key? key,required this.icon,required this.text}) : super(key: key);
  final IconData icon;
  final String text;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,color: kPrimaryColor,),
        SizedBox(width: 10,),
        Text(text,style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w400),),
      ],
    );
  }
}
