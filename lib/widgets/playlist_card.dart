import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/7_bts.png'))),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(9)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nice for what",
                              style: kDefaultTextStyle.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Text(
                              "Mother John",
                              style: kDefaultTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: kPrimaryColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
