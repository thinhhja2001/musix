import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      alignment: AlignmentDirectional.center,
      backgroundColor: Colors.transparent,
      // insetPadding: EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        height: 60,
        child: Center(
          child: SpinKitFadingFour(
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
