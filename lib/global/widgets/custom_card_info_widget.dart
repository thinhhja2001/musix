import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/theme.dart';

class CustomCardInfoWidget extends StatelessWidget {
  final int index;
  final String? image;
  final String title;

  final String? subTitle;
  final String? type;

  final VoidCallback? onCardPress;
  final VoidCallback? onButtonPress;
  final bool isShowIndex;
  final double padding;
  final bool isActive;
  final bool isShowAdditionButton;
  final Widget? additionWidget;

  const CustomCardInfoWidget({
    Key? key,
    required this.index,
    this.image,
    required this.title,
    this.subTitle,
    this.type,
    this.onCardPress,
    this.onButtonPress,
    this.isActive = false,
    this.isShowIndex = false,
    this.isShowAdditionButton = true,
    this.padding = 0,
    this.additionWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding, right: padding),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: ColorTheme.primaryLighten.withOpacity(0.3),
        onTap: onCardPress,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isShowIndex) ...[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      '#$index',
                      style: TextStyleTheme.ts16.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        3,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image ??
                            'https://images.unsplash.com/photo-1503248947681-3198a7abfcc9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                        fit: BoxFit.scaleDown,
                        placeholder: (context, url) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Shimmer.fromColors(
                            baseColor: ColorTheme.background,
                            highlightColor: ColorTheme.backgroundDarker,
                            child: const Material(
                              color: Colors.white,
                              child: SizedBox(
                                width: 48,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  )),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts14.copyWith(
                        color: isActive ? ColorTheme.primary : ColorTheme.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (subTitle != null)
                      Text(
                        subTitle!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts12.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorTheme.primary,
                        ),
                      ),
                    if (type != null)
                      Text(
                        type!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts10.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
              ),
              if (isShowAdditionButton)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: InkWell(
                      onTap: onButtonPress,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.8,
                            color: ColorTheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        width: 24,
                        height: 24,
                        child: const Center(
                          child: Icon(
                            Icons.more_horiz,
                            color: ColorTheme.primary,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  flex: 1,
                  child: additionWidget ?? const SizedBox.shrink(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
