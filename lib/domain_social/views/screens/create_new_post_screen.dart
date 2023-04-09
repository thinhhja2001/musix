import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:musix/domain_auth/views/widgets/custom_button_widget.dart';
import 'package:musix/domain_auth/views/widgets/custom_textfield_widget.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';

import '../widgets/posts/create_post_widget/select_thumbnail_widget.dart';

class CreateNewPostScreen extends StatelessWidget {
  const CreateNewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme.backgroundDarker,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: const Text("Create New Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Placeholder(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Content",
                          style:
                              TextStyleTheme.ts16.copyWith(color: Colors.grey),
                        ),
                        TextField(
                          style:
                              TextStyleTheme.ts28.copyWith(color: Colors.white),
                          maxLines: 2,
                          maxLength: 100,
                          decoration: InputDecoration(
                              counterStyle: TextStyleTheme.ts12
                                  .copyWith(color: Colors.grey),
                              hintText: "Caption your song",
                              hintStyle: TextStyleTheme.ts28
                                  .copyWith(color: Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            CustomInputFieldWidget(
              textInputType: TextInputType.text,
              label: "Song name",
              controller: TextEditingController(),
            ),
            const SizedBox(
              height: 50,
            ),
            const SelectThumbnailWidget(),
            const Spacer(),
            CustomButtonWidget(onPress: () {}, content: "Upload")
          ],
        ),
      ),
    );
  }
}
