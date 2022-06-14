import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/enums.dart';
import 'package:musix/widgets/customs/custom_input_field.dart';

class EditPlaylistWidget extends StatefulWidget {
  const EditPlaylistWidget({
    Key? key,
    required this.album,
  }) : super(key: key);
  final Album album;

  @override
  State<EditPlaylistWidget> createState() => _EditPlaylistWidgetState();
}

class _EditPlaylistWidgetState extends State<EditPlaylistWidget> {
  File? imageRaw;
  TextEditingController playlistEditingController = TextEditingController();
  bool isSaveable = true;
  String errorMessage = "";
  void onSaveButtonPress(BuildContext context) async {
    final newAlbumName = playlistEditingController.text;
    setState(() {
      if (newAlbumName.trim().isEmpty) {
        isSaveable = false;
        errorMessage = "Playlist name must contains at least 1 character";
      } else {
        isSaveable = true;
      }
    });
    if (isSaveable) {
      await PlaylistMethods.updateCustomAlbumData(
          album: widget.album, newThumbnail: imageRaw, newName: newAlbumName);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      color: kBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Edit playlist",
                    style: kDefaultTextStyle,
                  ),
                  TextButton(
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => onSaveButtonPress(context),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: imageRaw == null
                    ? Image.network(
                        widget.album.thumbnailUrl,
                        fit: BoxFit.fill,
                        height: 150,
                        width: 150,
                      )
                    : Image.file(
                        imageRaw!,
                        fit: BoxFit.fill,
                        height: 150,
                        width: 150,
                      ),
              ),
              TextButton(
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      imageRaw = File(image.path);
                    });
                  }
                },
                child: Text(
                  "Change Image",
                  style: kDefaultTextStyle.copyWith(fontSize: 15),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                      customInputFieldType: CustomInputFieldType.text,
                      label: 'Playlist name',
                      controller: playlistEditingController),
                  verticalSpaceSmall,
                  !isSaveable
                      ? Text(errorMessage,
                          style: kDefaultTextStyle.copyWith(color: Colors.red))
                      : Container(),
                ],
              ),
              Expanded(
                child: Container(),
              )
            ]),
      ),
    );
  }
}
