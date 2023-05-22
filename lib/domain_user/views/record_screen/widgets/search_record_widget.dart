import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/theme/theme.dart';

class SearchRecordWidget extends StatelessWidget {
  const SearchRecordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRecordBloc, UserRecordState>(
        builder: (context, state) {
      var searchRecord = state.record?.searchRecord ?? [];
      debugPrint('$searchRecord');
      if (searchRecord.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                r"There is nothing here.",
                style: TextStyleTheme.ts15.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }
      if (state.record?.searchHistory != null &&
          state.record!.searchHistory!.isNotEmpty) {
        searchRecord = searchRecord
            .where((element) => element.contains(state.record!.searchHistory!))
            .toList();
      } else {
        searchRecord = state.record?.searchRecord ?? [];
      }

      return ListView.builder(
        itemCount: searchRecord.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              searchRecord[index],
              style: TextStyleTheme.ts16.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
              ),
              onPressed: () {
                context.read<UserRecordBloc>().add(
                    DeleteUserSearchRecordEvent(search: searchRecord[index]));
              },
            ),
          );
        },
      );
    });
  }
}
