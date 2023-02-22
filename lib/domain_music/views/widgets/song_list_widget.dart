import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../entities/entities.dart';
import '../../logic/song_bloc.dart';
import '../../repository/song_source_repository.dart';
import '../../models/songs/song_info_model.dart';
import '../../services/musix_audio_handler.dart';
import '../widgets.dart';
import '../../../global/widgets/rotated_text_widget.dart';

class SongListWidget extends StatelessWidget {
  final String title;
  final List<SongInfoModel?> songs;
  final bool isShowIndex;
  final bool isScrollable;

  const SongListWidget({
    Key? key,
    required this.title,
    required this.songs,
    this.isShowIndex = true,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return Row(
          children: [
            RotatedTextWidget(text: title),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: isScrollable
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      songs.length,
                      (index) => SongCardWidget(
                        index: index + 1,
                        isRequestIndex: isShowIndex,
                        song: songs[index] ?? sampleSong,
                        onPress: () async {
                          context
                              .read<SongBloc>()
                              .add(SongGetInfoEvent(songs[index]!.encodeId!));

                          context.read<SongBloc>().add(
                                SongGetSourceEvent(
                                  songs[index]!.encodeId!,
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
