import 'package:flutter/material.dart';

import '../../../../theme/text_style.dart';

class SetTimerWidget extends StatelessWidget {
  const SetTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SetTimerButtonWidget(
                    time: 5,
                  ),
                  const _SetTimerButtonWidget(
                    time: 10,
                  ),
                  const _SetTimerButtonWidget(
                    time: 15,
                  ),
                  const _SetTimerButtonWidget(
                    time: 30,
                  ),
                  const _SetTimerButtonWidget(
                    time: 45,
                  ),
                  const _SetTimerButtonWidget(
                    time: 60,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "End of track",
                      style: TextStyleTheme.ts16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SetTimerButtonWidget extends StatelessWidget {
  const _SetTimerButtonWidget({
    required this.time,
  });

  ///In minute
  final int time;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "${time != 60 ? time : 1} ${time == 60 ? "hour" : "minutes"}",
        style: TextStyleTheme.ts16.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
