import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_auth/views/widgets/custom_textfield_widget.dart';
import 'package:musix/domain_social/entities/entities.dart';

import '../../../../theme/theme.dart';

class EditCommentWidget extends StatefulWidget {
  final Comment comment;
  final bool isReply;
  const EditCommentWidget({
    super.key,
    required this.comment,
    this.isReply = false,
  });

  @override
  State<EditCommentWidget> createState() => _EditCommentWidgetState();
}

class _EditCommentWidgetState extends State<EditCommentWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.comment.content);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: ColorTheme.backgroundDarker,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Edit Comment',
                  style: TextStyleTheme.ts20.copyWith(
                    color: ColorTheme.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomInputFieldWidget(
                textInputType: TextInputType.text,
                label: 'Content',
                controller: textEditingController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Comment is not valid';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    context.read<CommentBloc>().add(EditCommentEvent(
                          content: textEditingController.text,
                          commentId: widget.comment.id!,
                          isRely: widget.isReply,
                        ));
                    Future.delayed(const Duration(milliseconds: 300))
                        .whenComplete(() => Navigator.of(context).maybePop());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.background,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyleTheme.ts16.copyWith(
                        color: ColorTheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.primaryLighten,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      'Back',
                      style: TextStyleTheme.ts16.copyWith(
                        color: ColorTheme.backgroundDarker,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
