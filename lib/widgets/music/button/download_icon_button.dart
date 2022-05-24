import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DownloadIconButton extends StatelessWidget {
  const DownloadIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          MdiIcons.trayArrowDown,
          color: Colors.white,
        ));
  }
}
