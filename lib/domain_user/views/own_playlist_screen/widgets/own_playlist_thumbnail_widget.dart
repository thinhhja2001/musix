import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/theme/theme.dart';
import 'package:musix/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class OwnPlaylistThumbnailWidget extends StatefulWidget {
  final String playlistId;
  const OwnPlaylistThumbnailWidget({
    required this.playlistId,
    super.key,
  });

  @override
  State<OwnPlaylistThumbnailWidget> createState() =>
      _OwnPlaylistThumbnailWidgetState();
}

class _OwnPlaylistThumbnailWidgetState
    extends State<OwnPlaylistThumbnailWidget> {
  bool isChoosing = false;
  final imagePicker = ImagePicker();
  XFile? image;
  String? _error;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        image = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          isChoosing = true;
        });
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Upload Playlist Thumbnail',
                            style: TextStyleTheme.ts20.copyWith(
                              color: ColorTheme.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BlocConsumer<UserMusicBloc, UserMusicState>(
                            listener: (_, state) {
                          if (state.status?[
                                  UserMusicStatusKey.ownPlaylist.name] ==
                              Status.loading) {
                            _error = null;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const LoadingWidget();
                                });
                          } else if (state.status?[
                                  UserMusicStatusKey.ownPlaylist.name] ==
                              Status.success) {
                            Navigator.maybePop(context);
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Navigator.maybePop(context);
                              setState(() {
                                isChoosing = false;
                              });
                              Future.delayed(const Duration(milliseconds: 300))
                                  .then((value) => Fluttertoast.showToast(
                                      msg: "Update Thumbnail Success",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          ColorTheme.primaryLighten,
                                      textColor: ColorTheme.backgroundDarker,
                                      fontSize: 12));
                            });
                          }
                        }, builder: (context, state) {
                          if (state.status?[
                                  UserMusicStatusKey.ownPlaylist.name] ==
                              Status.error) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
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
                                onPressed: () {
                                  setState(() {
                                    isChoosing = false;
                                  });
                                  Navigator.maybePop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorTheme.background,
                                  padding: const EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Center(
                                    child: Text(
                                      'Back',
                                      style: TextStyleTheme.ts14.copyWith(
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
                                onPressed: () async {
                                  image!.readAsBytes().then((value) {
                                    List<int> imgByte = value.toList();
                                    context
                                        .read<UserMusicBloc>()
                                        .add(UploadThumbnailOwnPlaylistEvent(
                                          thumbnail: imgByte,
                                          playlistId: 'widget.playlistId,',
                                        ));
                                  });
                                  image = null;
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorTheme.primaryLighten,
                                  padding: const EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyleTheme.ts14.copyWith(
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
                );
              });
        });
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        child: ShaderMask(
          shaderCallback: (bound) {
            return LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white.withOpacity(0.01),
                Colors.white.withOpacity(0.4),
              ],
            ).createShader(bound);
          },
          blendMode: BlendMode.srcOver,
          child: isChoosing
              ? Image.file(
                  File(image!.path),
                  fit: BoxFit.fitWidth,
                )
              : BlocSelector<UserMusicBloc, UserMusicState, String?>(
                  selector: (state) {
                    return state.music?.ownPlaylists
                        ?.firstWhere(
                            (element) => element.id == widget.playlistId)
                        .thumbnail;
                  },
                  builder: (context, imgUrl) {
                    return CachedNetworkImage(
                      imageUrl: imgUrl ?? AssetPath.placeImage,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: ColorTheme.background,
                        highlightColor: ColorTheme.backgroundDarker,
                        child: Material(
                          color: Colors.white,
                          child: SizedBox(
                            width: context.size?.width,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                      fit: BoxFit.fitWidth,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
