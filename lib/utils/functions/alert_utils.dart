import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../domain_social/entities/post/post.dart';
import '../../domain_social/models/post/request/report_post_request_model.dart';
import '../../domain_social/repository/post/report_post_repo.dart';
import '../../domain_user/logic/profile_bloc.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

Future<dynamic> buildReportDialog(BuildContext context, Post post) {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: ColorTheme.background,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Please provide information",
                style: TextStyleTheme.ts22.copyWith(color: Colors.white),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please indicate your reason";
                  }
                  return null;
                },
                cursorColor: ColorTheme.primary,
                controller: controller,
                style: TextStyleTheme.ts18.copyWith(color: Colors.white),
                maxLines: 5,
                maxLength: 20,
                decoration: InputDecoration(
                    focusColor: ColorTheme.primary,
                    focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: ColorTheme.primary)),
                    counterStyle:
                        TextStyleTheme.ts18.copyWith(color: Colors.grey),
                    hintText: "Why would you want to report this?",
                    hintStyle:
                        TextStyleTheme.ts18.copyWith(color: Colors.grey)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyleTheme.ts14.copyWith(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final reportRequest = ReportPostRequestModel(
                            postId: post.id!,
                            userId: context.read<ProfileBloc>().state.user!.id!,
                            reason: controller.text);
                        buildShowLoadingDialog(context);
                        await ReportPostRepo().createNewReport(reportRequest,
                            "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbjEiLCJpYXQiOjE2ODk5NDAzODUsImV4cCI6MTY5MjUzMjM4NX0.fQgc-XyE90kN5WFe89KXwYy3NWT9UAryAK36-swX6es");
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Send",
                      style: TextStyleTheme.ts14
                          .copyWith(color: ColorTheme.primary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> buildShowLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black12,
    barrierDismissible: false,
    builder: (context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitChasingDots(
                color: Colors.white70,
              ),
            ],
          ),
        ),
      );
    },
  );
}
