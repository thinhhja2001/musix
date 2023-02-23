import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/widgets/rotated_text_widget.dart';
import '../../entities/entities.dart';
import '../../logic/song_bloc.dart';
import '../widgets.dart';

class SongListWidget extends StatelessWidget {
  final String title;
  final List<SongInfo?> songs;
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
                        song: songs[index]!,
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
