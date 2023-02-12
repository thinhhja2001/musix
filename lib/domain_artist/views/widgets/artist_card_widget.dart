import 'package:flutter/material.dart';
import 'package:musix/domain_artist/models/models.dart';
import 'package:musix/theme/theme.dart';

class ArtistCardWidget extends StatelessWidget {
  const ArtistCardWidget({
    Key? key,
    required this.artist,
    required this.index,
    this.padding = 16,
    this.isRequestIndex = true,
  }) : super(key: key);

  final Artist artist;
  final int index;
  final double padding;
  final bool isRequestIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding, right: padding),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: ColorTheme.primaryLighten.withOpacity(0.3),
        onTap: () async {},
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isRequestIndex) ...[
                Center(
                  child: Text(
                    '#$index',
                    style: TextStyleTheme.ts16.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 26 - (index.toString().length - 1) * 10,
                ),
              ],
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    3,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      artist.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  artist.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleTheme.ts14.copyWith(
                    color: ColorTheme.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
