import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/theme/theme.dart';

class SearchSongRecentWidget extends StatefulWidget {
  const SearchSongRecentWidget({Key? key}) : super(key: key);

  @override
  State<SearchSongRecentWidget> createState() => _SearchSongRecentWidgetState();
}

class _SearchSongRecentWidgetState extends State<SearchSongRecentWidget> {
  GlobalKey key = GlobalKey<State<SearchSongRecentWidget>>();
  Timer? searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping?.cancel());
    }
    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  search(value) {
    key.currentContext
        ?.read<UserRecordBloc>()
        .add(SearchRecentSongEvent(value));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white54),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white54),
        ),
        hintText: 'Search...',
        hintStyle: TextStyleTheme.ts16.copyWith(color: Colors.white54),
      ),
      style: TextStyleTheme.ts16
          .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      onChanged: _onChangeHandler,
    );
  }
}
