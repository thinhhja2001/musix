import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config/exporter.dart';
import '../../../../domain_song/entities/entities.dart';
import '../../../entities/entities.dart';
import '../../../../global/widgets/widgets.dart';
import '../../../../utils/utils.dart';

import '../../../../theme/theme.dart';

class SaveSongOwnPlaylistWidget extends StatefulWidget {
  final SongInfo song;
  const SaveSongOwnPlaylistWidget({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  State<SaveSongOwnPlaylistWidget> createState() =>
      _SaveSongOwnPlaylistWidgetState();
}

class _SaveSongOwnPlaylistWidgetState extends State<SaveSongOwnPlaylistWidget> {
  final Map<String, bool> playlistSelected = {};
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: AlignmentDirectional.center,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: ColorTheme.backgroundDarker,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Save Song To Playlist',
                  style: TextStyleTheme.ts20.copyWith(
                    color: ColorTheme.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              BlocSelector<UserMusicBloc, UserMusicState, List<OwnPlaylist>>(
                selector: (state) {
                  if (state.music?.ownPlaylists?.isNotEmpty == true) {
                    for (var playlist in state.music!.ownPlaylists!) {
                      if (!playlistSelected.containsKey(playlist.id!)) {
                        if (playlist.songs!.contains(widget.song.encodeId)) {
                          playlistSelected[playlist.id!] = true;
                        } else {
                          playlistSelected[playlist.id!] = false;
                        }
                      }
                    }
                  }
                  return state.music?.ownPlaylists ?? [];
                },
                builder: (context, playlists) {
                  if (playlists.isEmpty) {
                    return Center(
                      child: Text(
                        'Please create own playlist!',
                        style: TextStyleTheme.ts16.copyWith(
                          color: ColorTheme.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        return Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: CheckboxListTile(
                              title: Text(
                                playlists[index].title!,
                                style: TextStyleTheme.ts14.copyWith(
                                  color: ColorTheme.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: const BorderSide(color: Colors.pink),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: ColorTheme.primaryLighten,
                              value: playlistSelected[playlists[index].id!],
                              onChanged: (newValue) {
                                setState(() {
                                  playlistSelected[playlists[index].id!] =
                                      newValue ?? false;
                                });
                              }),
                        );
                      });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              BlocConsumer<UserMusicBloc, UserMusicState>(listener: (_, state) {
                if (state.status?[UserMusicStatusKey.ownPlaylist.name] ==
                    Status.loading) {
                  _error = null;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const LoadingWidget();
                      });
                } else if (state.status?[UserMusicStatusKey.ownPlaylist.name] ==
                    Status.success) {
                  Navigator.maybePop(context);
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.maybePop(context);
                    Future.delayed(const Duration(milliseconds: 300)).then(
                        (value) => Fluttertoast.showToast(
                            msg: "Save Song In Playlist Success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ColorTheme.primaryLighten,
                            textColor: ColorTheme.backgroundDarker,
                            fontSize: 12));
                  });
                }
              }, builder: (context, state) {
                if (state.status?[ProfileStatusKey.uploadProfile.name] ==
                    Status.error) {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.maybePop(context);
                  });
                  _error = state.error?.message;
                }
                return Text(
                  _error ?? "",
                  style: TextStyleTheme.ts10.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                );
              }),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      onPressed: () => Navigator.maybePop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.background,
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: SizedBox(
                        height: 30,
                        width: double.maxFinite,
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyleTheme.ts16.copyWith(
                              color: ColorTheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      onPressed: () {
                        List<String> playlistIds = [];
                        playlistSelected.forEach((key, value) {
                          if (value == true) {
                            playlistIds.add(key);
                          }
                        });
                        context.read<UserMusicBloc>().add(
                              UploadSongOwnPlaylistEvent(
                                playlistIds: playlistIds,
                                id: widget.song.encodeId!,
                                title: widget.song.title!,
                                artistNames: widget.song.artistsNames!,
                                genreNames: widget.song.genreNames,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.primaryLighten,
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: SizedBox(
                        height: 30,
                        width: double.maxFinite,
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyleTheme.ts16.copyWith(
                              color: ColorTheme.backgroundDarker,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
