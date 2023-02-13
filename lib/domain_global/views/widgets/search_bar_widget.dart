import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final List<String?> recommends;
  final Function(String)? onTextChange;
  const SearchBarWidget({
    Key? key,
    required this.hintText,
    required this.recommends,
    this.onTextChange,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _searchController = TextEditingController();
  bool _isShowAdvance = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      widget.onTextChange?.call(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorTheme.bottomNavigationBar,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                    Expanded(
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
                              color: ColorTheme.grey100,
                              fontWeight: FontWeight.w400,
                            ),
                            fillColor: Colors.blue),
                      ),
                    ),
                    Container(
                      width: 60,
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
                    )
                  ],
                ),
              ),
            ),
          ),
          if (_isShowAdvance) ...[
            const SizedBox(
              height: 4,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: [
                for (String? text in widget.recommends) ...[
                  if (text != null)
                    ChoiceChip(
                      label: Text(text),
                      selected: false,
                      selectedColor: ColorTheme.primaryLighten,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _searchController.text = text;
                        });
                      },
                      backgroundColor: ColorTheme.primary,
                      labelStyle: TextStyleTheme.ts15.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                ]
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isShowAdvance = false;
                      });
                    },
                    child: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 24,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ],
          if (!_isShowAdvance) ...[
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isShowAdvance = true;
                      });
                    },
                    child: const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 24,
                        color: Colors.white,
                      ),
                    )),
              ),
            )
          ],
        ],
      ),
    );
  }
}
