import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_song/views/widgets.dart';
import 'package:musix/theme/theme.dart';

import 'widget.dart';

class SongRecordScreen extends StatelessWidget {
  const SongRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      appBar: AppBarRecordWidget(
        title: 'Song Recent',
        actionWidget: BlocSelector<UserRecordBloc, UserRecordState, bool>(
          selector: (state) => state.record?.songRecord?.isNotEmpty ?? false,
          builder: (context, canDelete) {
            return canDelete
                ? IconButton(
                    onPressed: () => context.read<UserRecordBloc>().add(
                        const DeleteUserSongRecordEvent(isDeleteAll: true)),
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.redAccent,
                    ))
                : const SizedBox.shrink();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: const [
            SearchSongRecentWidget(),
            SizedBox(
              height: 20,
            ),
            SongRecentWidget(),
          ],
        ),
      ),
    );
  }
}
