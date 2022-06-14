import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';

class TimerIconButton extends StatefulWidget {
  const TimerIconButton({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerIconButton> createState() => _TimerIconButtonState();
}

class _TimerIconButtonState extends State<TimerIconButton> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return IconButton(
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Stop audio in",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (timer!.isActive) {
                            timer!.cancel();
                          }
                          timer = Timer(Duration(seconds: 5), () {
                            showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Stop playing song",
                                icon: Icons.timer);
                            audioPlayerProvider.pauseSong();
                          });
                          showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Set pause song succesfully",
                                icon: Icons.timer);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "5 seconds",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (timer!.isActive) {
                            timer!.cancel();
                          }
                          timer = Timer(Duration(minutes: 10), () {
                            showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Stop playing song",
                                icon: Icons.timer);
                            audioPlayerProvider.pauseSong();
                          });
                          showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Set pause song succesfully",
                                icon: Icons.timer);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "10 minutes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (timer!.isActive) {
                            timer!.cancel();
                          }
                          timer = Timer(Duration(minutes: 15), () {
                            showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Stop playing song",
                                icon: Icons.timer);
                            audioPlayerProvider.pauseSong();
                          });
                          showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Set pause song succesfully",
                                icon: Icons.timer);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "15 minutes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (timer!.isActive) {
                            timer!.cancel();
                          }
                          timer = Timer(Duration(minutes: 30), () {
                            showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Stop playing song",
                                icon: Icons.timer);
                            audioPlayerProvider.pauseSong();
                          });
                          showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Set pause song succesfully",
                                icon: Icons.timer);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "30 minutes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (timer!.isActive) {
                            timer!.cancel();
                          }
                          timer = Timer(Duration(hours: 1), () {
                            showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Stop playing song",
                                icon: Icons.timer);
                            audioPlayerProvider.pauseSong();
                          });
                          showCompleteNotification(
                                title: "Set sleep timer",
                                message: "Set pause song succesfully",
                                icon: Icons.timer);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "1 hour",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        icon: const Icon(
          MdiIcons.weatherNight,
          color: Colors.white,
        ));
  }
}
