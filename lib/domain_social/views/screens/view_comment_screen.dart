import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/domain_social/views/widgets/comments/comment_card_widget.dart';
import 'package:musix/theme/theme.dart';

import '../widgets/comments/comment_field_widget.dart';

class ViewCommentScreen extends StatelessWidget {
  const ViewCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3,
      decoration: const BoxDecoration(
        color: ColorTheme.backgroundDarker,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Comment",
                style: TextStyleTheme.ts28.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              BlocSelector<CommentBloc, CommentState, int>(
                selector: (state) {
                  return state.comments?.length ?? 0;
                },
                builder: (context, total) {
                  return Text(
                    "$total",
                    style: TextStyleTheme.ts16.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(.7),
                    ),
                  );
                },
              ),
              const Spacer(),
              BlocSelector<CommentBloc, CommentState, bool>(
                selector: (state) {
                  return state.isFilter ?? false;
                },
                builder: (context, isFilter) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<CommentBloc>()
                          .add(FilterCommentEvent(!isFilter));
                    },
                    icon: Icon(
                      isFilter ? Icons.filter_list_off : Icons.filter_list,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocSelector<CommentBloc, CommentState, List<Comment>>(
              selector: (state) {
                return state.comments ?? [];
              },
              builder: (context, comments) {
                if (comments.isEmpty) {
                  return Text(
                    'There is no comments in this post',
                    style: TextStyleTheme.ts16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) => CommentCardWidget(
                    comment: comments[index],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: comments.length,
                );
              },
            ),
          ),
          CommentFieldWidget()
        ],
      ),
    );
  }
}
