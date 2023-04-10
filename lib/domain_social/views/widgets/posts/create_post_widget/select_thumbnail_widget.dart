import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';

import '../../../../../theme/theme.dart';
import '../../../../entities/state/social_state.dart';

class SelectThumbnailWidget extends StatefulWidget {
  const SelectThumbnailWidget({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;

  @override
  State<SelectThumbnailWidget> createState() => _SelectThumbnailWidgetState();
}

class _SelectThumbnailWidgetState extends State<SelectThumbnailWidget> {
  bool isThumbnailSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return InkWell(
          splashColor: ColorTheme.primary.withOpacity(.4),
          onTap: () async {
            state.createPostThumbnail == null
                ? _showPickingImageSourceChoice(context)
                : null;
          },
          child: state.createPostThumbnail == null
              ? DottedBorder(
                  radius: const Radius.circular(10),
                  color: ColorTheme.primary,
                  borderType: BorderType.RRect,
                  child: Center(
                    child: SizedBox(
                      width: widget.width ?? 100,
                      height: widget.height ?? 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image,
                            size: 50,
                            color: ColorTheme.white,
                          ),
                          Text(
                            "Select your thumbnail",
                            textAlign: TextAlign.center,
                            style: TextStyleTheme.ts12
                                .copyWith(color: ColorTheme.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => setState(() {
                    isThumbnailSelected = !isThumbnailSelected;
                  }),
                  child: SizedBox(
                    width: widget.width ?? 100,
                    height: widget.height ?? 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: Image.file(
                              File(state.createPostThumbnail!.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                          AnimatedContainer(
                            width: double.infinity,
                            height: double.infinity,
                            duration: const Duration(milliseconds: 500),
                            color: isThumbnailSelected
                                ? Colors.black.withOpacity(.5)
                                : Colors.transparent,
                            child: isThumbnailSelected
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 30),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<SocialBloc>().add(
                                            SocialRemovePostThumbnailEvent());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorTheme.primary),
                                      child: Center(
                                        child: Text(
                                          "Remove",
                                          style: TextStyleTheme.ts12.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Future<dynamic> _showPickingImageSourceChoice(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: ColorTheme.backgroundDarker,
        context: context,
        builder: (_) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then(
                          (value) => context.read<SocialBloc>().add(
                                SocialAddPostThumbnailEvent(value),
                              ),
                        );
                  },
                  child: Text(
                    "From gallery",
                    style:
                        TextStyleTheme.ts14.copyWith(color: ColorTheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.camera)
                        .then(
                          (value) => context.read<SocialBloc>().add(
                                SocialAddPostThumbnailEvent(value),
                              ),
                        );
                  },
                  child: Text(
                    "From camera",
                    style:
                        TextStyleTheme.ts14.copyWith(color: ColorTheme.primary),
                  ),
                ),
              ],
            ));
  }
}
