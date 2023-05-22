import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_song/views/widgets.dart';
import 'package:musix/theme/theme.dart';

import 'widget.dart';

class SearchRecordScreen extends StatelessWidget {
  const SearchRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      appBar: AppBarRecordWidget(
        title: 'Search History',
        actionWidget: BlocSelector<UserRecordBloc, UserRecordState, bool>(
          selector: (state) => state.record?.searchRecord?.isNotEmpty ?? false,
          builder: (context, canDelete) {
            return canDelete
                ? IconButton(
                    onPressed: () => context.read<UserRecordBloc>().add(
                        const DeleteUserSearchRecordEvent(isDeleteAll: true)),
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.redAccent,
                    ))
                : const SizedBox.shrink();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: const [
            SearchTextFieldWidget(),
            SizedBox(
              height: 20,
            ),
            SearchRecordWidget(),
          ],
        ),
      ),
    );
  }
}
