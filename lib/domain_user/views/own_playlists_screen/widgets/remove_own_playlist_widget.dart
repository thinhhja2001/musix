import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/theme/theme.dart';

class RemoveOwnPlaylistWidget extends StatelessWidget {
  final String playlistId;
  const RemoveOwnPlaylistWidget({
    Key? key,
    required this.playlistId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: AlignmentDirectional.center,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
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
                          RemoveOwnPlaylistEvent(playlistId),
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
    );
  }
}
