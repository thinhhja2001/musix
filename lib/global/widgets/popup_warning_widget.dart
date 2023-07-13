import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class PopupWarningWidget extends StatelessWidget {
  final String description;
  final VoidCallback? onTap;
  const PopupWarningWidget({
    Key? key,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: ColorTheme.backgroundDarker,
      child: Container(
        decoration: BoxDecoration(
          color: ColorTheme.backgroundDarker,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Warning',
                style: TextStyleTheme.ts20.copyWith(
                  color: ColorTheme.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Text(
                description,
                style: TextStyleTheme.ts16.copyWith(
                  color: ColorTheme.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                onTap?.call();
                Navigator.of(context).maybePop();
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
    );
  }
}
