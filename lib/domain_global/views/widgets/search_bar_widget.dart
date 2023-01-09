import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  const SearchBarWidget({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorTheme.bottomNavigationBar,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorTheme.background,
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
                    controller: _searchController,
                    style: TextStyleTheme.ts15.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    cursorColor: ColorTheme.primary,
                    decoration: InputDecoration.collapsed(
                        hintText: widget.hintText,
                        hintStyle: TextStyleTheme.ts15.copyWith(
                          color: ColorTheme.gray100,
                          fontWeight: FontWeight.w400,
                        ),
                        fillColor: Colors.blue),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorTheme.primaryLighten,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          // context
                          //     .read<SearchProvider>()
                          //     .getSongByAll(textController.text);
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
