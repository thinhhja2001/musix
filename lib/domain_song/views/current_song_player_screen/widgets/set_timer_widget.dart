import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/exporter.dart';
import '../../../../theme/theme.dart';

class SetTimerWidget extends StatefulWidget {
  const SetTimerWidget({super.key, required this.context});

  final BuildContext context;

  @override
  State<SetTimerWidget> createState() => _SetTimerWidgetState();
}

class _SetTimerWidgetState extends State<SetTimerWidget> {
  Timer timer = Timer(const Duration(seconds: 0), (() {}));
  final timerIndex = [5, 10, 15, 30, 45, 60];
  List<int> checks = [0, 0, 0, 0, 0, 0];
  onChangeTimer(int time) {
    if (timer.isActive) {
      timer.cancel();
    }
    if (checks[timerIndex.indexOf(time)] == 0) {
      checks = calculateChecks(time);
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      timer = Timer(Duration(seconds: time), () {
        showModalBottomSheet(
            backgroundColor: ColorTheme.backgroundDarker,
            context: widget.context,
            builder: (context) => ListTile(
                  leading: const Icon(
                    Icons.timer,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Set sleep timer",
                    style: TextStyleTheme.ts14.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "Stop playing song",
                    style: TextStyleTheme.ts14.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ));
        timer.cancel();
        widget.context.read<SongBloc>().add(SongPauseEvent());
      });
    });
    if (!mounted) return;
    setState(() {});
    Navigator.maybePop(context);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
          backgroundColor: ColorTheme.backgroundDarker,
          context: widget.context,
          builder: (context) => ListTile(
                leading: const Icon(
                  Icons.timer,
                  color: Colors.white,
                ),
                title: Text(
                  "Set sleep timer",
                  style: TextStyleTheme.ts14.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "Set pause song successfully",
                  style: TextStyleTheme.ts14.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ));
    });
  }

  List<int> calculateChecks(int time) {
    switch (time) {
      case 5:
        return [1, 0, 0, 0, 0, 0];
      case 10:
        return [0, 1, 0, 0, 0, 0];
      case 15:
        return [0, 0, 1, 0, 0, 0];
      case 30:
        return [0, 0, 0, 1, 0, 0];
      case 45:
        return [0, 0, 0, 0, 1, 0];
      case 60:
        return [0, 0, 0, 0, 0, 1];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stop audio in",
            style: TextStyleTheme.ts20.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          _SetTimerButtonWidget(
            onTap: () => onChangeTimer(timerIndex[0]),
            time: timerIndex[0],
            check: checks[0] == 1,
          ),
          const SizedBox(
            height: 12,
          ),
          _SetTimerButtonWidget(
            onTap: () => onChangeTimer(timerIndex[1]),
            time: timerIndex[1],
            check: checks[1] == 1,
          ),
          const SizedBox(
            height: 12,
          ),
          _SetTimerButtonWidget(
            onTap: () => onChangeTimer(timerIndex[2]),
            time: timerIndex[2],
            check: checks[2] == 1,
          ),
          const SizedBox(
            height: 12,
          ),
          _SetTimerButtonWidget(
            onTap: () => onChangeTimer(timerIndex[3]),
            time: timerIndex[3],
            check: checks[3] == 1,
          ),
          const SizedBox(
            height: 12,
          ),
          _SetTimerButtonWidget(
            onTap: () => onChangeTimer(timerIndex[4]),
            time: timerIndex[4],
            check: checks[4] == 1,
          ),
          const SizedBox(
            height: 12,
          ),
          _SetTimerButtonWidget(
            onTap: () => onChangeTimer(timerIndex[5]),
            time: timerIndex[5],
            check: checks[5] == 1,
          )
        ],
      ),
    );
  }
}

class _SetTimerButtonWidget extends StatelessWidget {
  const _SetTimerButtonWidget({
    required this.time,
    this.onTap,
    this.check = false,
  });

  ///In minute
  final int time;
  final VoidCallback? onTap;
  final bool check;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: check
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            flex: 9,
            child: Text(
              "${time != 60 ? time : 1} ${time == 60 ? "hour" : "minutes"}",
              style: TextStyleTheme.ts16.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
