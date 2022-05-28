import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../providers/search_provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromRGBO(56, 54, 118, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: TextField(
                        controller: textController,
                        style: kDefaultTextStyle,
                        decoration: new InputDecoration.collapsed(
                            hintText: "Search by name",
                            hintStyle: kDefaultHintStyle,
                            fillColor: Colors.blue),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimaryColorLighten,
                        ),
                        child: IconButton(
                          onPressed: () {
                            context.read<SearchProvider>().getSongByAll(textController.text);
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
