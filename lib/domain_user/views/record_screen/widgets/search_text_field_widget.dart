import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/theme/theme.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({Key? key}) : super(key: key);

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  GlobalKey key = GlobalKey<State<SearchTextFieldWidget>>();
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
    key.currentContext?.read<UserRecordBloc>().add(SearchHistoryEvent(value));
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
