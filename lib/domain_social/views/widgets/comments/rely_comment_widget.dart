import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/theme/theme.dart';
import 'package:musix/utils/utils.dart';

import 'comment_card_widget.dart';
import 'comment_field_widget.dart';

class RelyCommentWidget extends StatelessWidget {
  final Comment comment;
  const RelyCommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
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
                    "Rely Comment",
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
                      return state.relyComments?.length ?? 0;
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
              CommentCardWidget(
                comment: comment,
                isShowReply: false,
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    if (state.status?[CommentStatusKey.rely] ==
                        Status.loading) {
                      return const SizedBox(
                        height: 60,
                        child: Center(
                          child: SpinKitFadingFour(
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      );
                    }
                    if (state.relyComments == null ||
                        state.relyComments!.isEmpty) {
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
                      padding: const EdgeInsets.only(left: 24),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) => CommentCardWidget(
                        comment: state.relyComments![index],
                        isRely: true,
                        isShowReply: false,
                      ),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: state.relyComments!.length,
                    );
                  },
                ),
              ),
              BlocListener<CommentBloc, CommentState>(
                listener: (context, state) {
                  if (state.status?[CommentStatusKey.rely] == Status.loading) {
                    showDialog(
                        context: context,
                        builder: (context) => const LoadingWidget());
                  } else if (state.status?[CommentStatusKey.rely] ==
                          Status.success ||
                      state.status?[CommentStatusKey.rely] == Status.error) {
                    Navigator.of(context).maybePop();
                  }
                },
                child: const CommentFieldWidget(
                  isRely: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
