import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config/exporter.dart';
import '../../../../global/widgets/widgets.dart';
import '../../../../theme/theme.dart';

import '../../../../utils/utils.dart';

class RemoveOwnPlaylistWidget extends StatefulWidget {
  final String playlistId;
  const RemoveOwnPlaylistWidget({
    Key? key,
    required this.playlistId,
  }) : super(key: key);

  @override
  State<RemoveOwnPlaylistWidget> createState() =>
      _RemoveOwnPlaylistWidgetState();
}

class _RemoveOwnPlaylistWidgetState extends State<RemoveOwnPlaylistWidget> {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Remove Own Playlist',
                style: TextStyleTheme.ts20.copyWith(
                  color: ColorTheme.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Text(
                'Are you sure to remove this playlist?',
                style: TextStyleTheme.ts14.copyWith(
                  color: ColorTheme.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            BlocConsumer<UserMusicBloc, UserMusicState>(listener: (_, state) {
              if (state.status?[UserMusicStatusKey.ownPlaylist.name] ==
                  Status.loading) {
                _error = null;
                showDialog(
                    barrierDismissible: false,
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
                          msg: "Remove Playlist Success",
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
                          'Back',
                          style: TextStyleTheme.ts16.copyWith(
                            color: ColorTheme.backgroundDarker,
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
                      context.read<UserMusicBloc>().add(
                            RemoveOwnPlaylistEvent(widget.playlistId),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
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
                          'Remove',
                          style: TextStyleTheme.ts16.copyWith(
                            color: ColorTheme.white,
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
    );
  }
}
