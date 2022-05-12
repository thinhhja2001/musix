import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/screens/profile_screen.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/widgets/profile/user_info.dart';

class SettingComponent extends StatelessWidget {
  const SettingComponent({ Key? key,required this.settingIcon,required this.settingText }) : super(key: key);
  final IconData settingIcon;
  final String settingText;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                Get.to(UserInfo(username: "deptrai",email: "19522408",phone: "0862751020",));  
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(settingIcon, size: 40, color: kPrimaryColorLighten),
                          SizedBox(width: 10,),
                          Text(settingText,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}