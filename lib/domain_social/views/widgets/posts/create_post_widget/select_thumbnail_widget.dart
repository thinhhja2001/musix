import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';

import '../../../../../theme/theme.dart';
import '../../../../entities/state/social_state.dart';

class SelectThumbnailWidget extends StatelessWidget {
  const SelectThumbnailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            state.createPostThumbnail == null
                ? _showSelectImageSourceMethod(context)
                : null;
          },
          child: state.createPostThumbnail == null
              ? DottedBorder(
                  radius: const Radius.circular(10),
                  color: ColorTheme.primary,
                  borderType: BorderType.RRect,
                  child: Center(
                      child: SizedBox(
                          width: double.infinity,
                          height: 200,
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
                                style: TextStyleTheme.ts16
                                    .copyWith(color: ColorTheme.white),
                              ),
                            ],
                          ))))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.memory(
                        Uint8List.fromList(state.createPostThumbnail!)),
                  ),
                ),
        );
      },
    );
  }

  Future<dynamic> _showSelectImageSourceMethod(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: ColorTheme.background,
        context: context,
        builder: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.camera)
                        .then(
                          (image) => {
                            context.read<SocialBloc>().add(
                                  SocialAddCreatePostThumbnailEvent(image),
                                )
                          },
                        );
                  },
                  child: Text(
                    "From your gallery",
                    style:
                        TextStyleTheme.ts14.copyWith(color: ColorTheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((image) => {
                              context.read<SocialBloc>().add(
                                    SocialAddCreatePostThumbnailEvent(image),
                                  )
                            });
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
