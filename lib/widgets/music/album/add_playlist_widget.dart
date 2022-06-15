import 'package:flutter/material.dart';
import 'package:musix/models/song.dart';
import 'package:musix/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../../providers/audio_player_provider.dart';
import '../../../resources/playlist_methods.dart';
import '../../../utils/colors.dart';
import '../../../utils/enums.dart';
import '../../customs/custom_button.dart';
import '../../customs/custom_input_field.dart';

class AddPlaylistWidget extends StatefulWidget {
  const AddPlaylistWidget({
    Key? key,
    required this.song,
  }) : super(key: key);
  final Song song;
  @override
  State<AddPlaylistWidget> createState() => _AddPlaylistWidgetState();
}

class _AddPlaylistWidgetState extends State<AddPlaylistWidget> {
  TextEditingController playlistTextController = TextEditingController();
  bool isLoading = false;
  bool isValid = true;
  String invalidMessage = "";
  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);

    void _createPlaylist() async {
      if (playlistTextController.text.trim() == '') {
        setState(() {
          isValid = false;
          invalidMessage = "Playlist name must contains at least one character";
        });
        return;
      }
      setState(() {
        isLoading = true;
      });

      String result = await PlaylistMethods.createPlaylist(
          playlistTextController.text, widget.song);

      setState(() {
        isLoading = false;
        invalidMessage = result;
        playlistTextController.text = '';
        if (invalidMessage != 'success') {
          isValid = false;
        } else {
          //Close current modalBottomSheet
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: kBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpaceLarge,
          Text(
            'Give your playlist a name',
            style: kDefaultTextStyle.copyWith(fontSize: 25),
          ),
          verticalSpaceLarge,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                    customInputFieldType: CustomInputFieldType.text,
                    label: 'Playlist name',
                    controller: playlistTextController),
                !isValid
                    ? Text(
                        invalidMessage,
                        style: kDefaultTextStyle.copyWith(color: Colors.red),
                      )
                    : Container(),
                verticalSpaceSmall,
                CustomButton(
                    onPress: _createPlaylist,
                    content: 'Create',
                    isLoading: isLoading)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
