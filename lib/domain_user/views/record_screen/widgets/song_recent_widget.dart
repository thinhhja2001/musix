import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_song/views/widgets.dart';
import 'package:musix/theme/theme.dart';

class SongRecentWidget extends StatelessWidget {
  const SongRecentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRecordBloc, UserRecordState>(
        builder: (context, state) {
      var songRecord = state.record?.songRecord ?? {};
      if (songRecord.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                r"There is nothing here.",
                style: TextStyleTheme.ts15.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }
      if (state.record?.searchSong != null &&
          state.record!.songRecord!.isNotEmpty) {
        songRecord = {
          for (final key in songRecord.keys)
            if (songRecord[key]!.title!.contains(state.record!.searchSong!))
              key: songRecord[key]!
        };
      } else {
        songRecord = state.record?.songRecord ?? {};
      }

      return ListView.builder(
        itemCount: songRecord.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var songInfo = songRecord[(songRecord.keys.toList())[index]];

          return ListTile(
            title: SongCardWidget(
              index: index + 1,
              isShowIndex: false,
              isShowType: false,
              type: SongType.cardInfo,
              song: songInfo!,
              onPress: () async {
                context.read<SongBloc>().add(SongSetListSongInfoEvent(
                      songRecord.values.toList(),
                    ));
                context
                    .read<SongBloc>()
                    .add(SongStartPlayingSectionEvent(index));
              },
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
              ),
              onPressed: () {
                context
                    .read<UserRecordBloc>()
                    .add(DeleteUserSongRecordEvent(search: songInfo));
              },
            ),
          );
        },
      );
    });
  }
}
