import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../config/exporter.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

class ArtistsInfoScreen extends StatelessWidget {
  const ArtistsInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocSelector<ArtistsBloc, ArtistsState, String>(
          selector: (state) => state.title ?? "",
          builder: (context, title) {
            return Text(title);
          },
        ),
        titleTextStyle: TextStyleTheme.ts22
            .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
        leading: IconButton(
          onPressed: () {
            context.read<ArtistsBloc>().add(const BackArtistsEvent());
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: BlocBuilder<ArtistsBloc, ArtistsState>(
        builder: (context, state) {
          if (state.status?[ArtistsStatusKey.global.name] == Status.loading) {
            return const Center(
                child: SpinKitPulse(
              color: ColorTheme.primary,
              size: 100,
            ));
          } else {
            var artists = state.artists;
            if (artists == null || artists.isEmpty == true) {
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
                      r"There's no artists here",
                      style: TextStyleTheme.ts15.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    artists.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomCardInfoWidget(
                          index: index,
                          image: artists[index].thumbnailM,
                          title: artists[index].name!,
                          padding: 0,
                          onCardPress: () {
                            context
                                .read<ArtistBloc>()
                                .add(ArtistGetInfoEvent(artists[index].alias!));
                            Navigator.pushNamed(
                              context,
                              RoutingPath.artistInfo,
                            );
                          },
                          isShowAdditionButton: false,
                          additionWidget: IconButton(
                            onPressed: () {
                              context.read<ArtistsBloc>().add(
                                  RemoveArtistEvent(artists[index].alias!));
                              context
                                  .read<UserMusicBloc>()
                                  .add(FavoriteArtistEvent(
                                    id: artists[index].id!,
                                    name: artists[index].name!,
                                    alias: artists[index].alias!,
                                  ));
                            },
                            icon: Icon(
                              state.title!.contains("Favorite")
                                  ? Icons.favorite
                                  : Icons.do_disturb_on,
                              color: Colors.redAccent,
                              size: 24,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
