import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
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
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return InkWell(
          splashColor: ColorTheme.primary.withOpacity(.4),
          onTap: () async {
            state.createPostThumbnail == null
                ? await FilePicker.platform
                    .pickFiles(type: FileType.image)
                    .then(
                      (result) => {
                        context.read<SocialBloc>().add(
                              SocialAddPostThumbnailEvent(result?.files.first),
                            )
                      },
                    )
                : null;
          },
          child: state.createPostThumbnail == null
              ? DottedBorder(
                  radius: const Radius.circular(10),
                  color: ColorTheme.primary,
                  borderType: BorderType.RRect,
                  child: Center(
                    child: SizedBox(
                      width: width ?? 100,
                      height: height ?? 100,
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
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: width ?? 100,
                    height: height ?? 100,
                    child: Image.file(
                      File(state.createPostThumbnail!.path!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
