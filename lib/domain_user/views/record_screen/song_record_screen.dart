import 'package:flutter/material.dart';
import 'package:musix/domain_song/views/widgets.dart';
import 'package:musix/theme/theme.dart';

class SongRecordScreen extends StatelessWidget {
  const SongRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          'Recent Song History',
          style: TextStyleTheme.ts20.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
