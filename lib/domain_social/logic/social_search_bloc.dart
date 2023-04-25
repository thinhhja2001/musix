import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/domain_user/utils/convert_model_entity.dart';
import 'package:musix/utils/utils.dart';

import '../../config/exporter.dart';

class SocialSearchBloc extends Bloc<SocialSearchEvent, SocialSearchState> {
  SocialSearchBloc({
    required SocialSearchState initialState,
    required this.profileRepo,
    required this.authBloc,
    required this.postRepo,
  }) : super(initialState) {
    authBloc.stream.listen((state) {
      if (state.jwtToken != null && state.jwtToken != "") {
        token = state.jwtToken!;
        socialMapper = SocialMapper(token);
      }
    });
    on<SearchAllSocialEvent>(_searchSocial);
    on<SearchMorePostEvent>(_searchPostMore);
    on<ClearSearchEvent>(_clearSearch);
    on<ResetSearchEvent>(_resetSearch);
  }
  final AuthBloc authBloc;
  final ProfileRepo profileRepo;
  final PostRepo postRepo;
  String token = "";
  late SocialMapper socialMapper;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> _searchSocial(
      SearchAllSocialEvent event, Emitter<SocialSearchState> emit) async {
    try {
      DebugLogger().log(token);
      if (state.search == event.query || event.query == "") return;

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            SocialSearchStatusKey.global.name,
          ], status: [
            Status.loading,
          ]),
          search: event.query,
        ),
      );

      final profilesModel = await profileRepo.searchProfile(token, event.query);
      final postsModel = await postRepo.getPostsByQuery(
          query: event.query, page: 0, size: 20, token: token);

      final users = convertListUserModelToListUser(profilesModel.users ?? []);
      final posts = await socialMapper.listPostsFromListPostsModel(postsModel);
      final socialSearch = SocialSearchValue(
        posts: posts,
        users: users,
      );
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          SocialSearchStatusKey.global.name,
        ], status: [
          Status.success,
        ]),
        values: socialSearch,
      ));
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            SocialSearchStatusKey.global.name,
          ], status: [
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(
          Exception("SocialSearchBloc _searchSocial error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          SocialSearchStatusKey.global.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _searchPostMore(
      SearchMorePostEvent event, Emitter<SocialSearchState> emit) async {
    try {
      if (state.search != null) return;
      var socialSearch = state.values;
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            SocialSearchStatusKey.posts.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );

      final postsModel = await postRepo.getPostsByQuery(
          query: state.search!,
          page: (socialSearch?.posts?.length ?? 0) ~/ 20,
          size: 20,
          token: token);
      final posts = await socialMapper.listPostsFromListPostsModel(postsModel);
      socialSearch = state.values?.copyWith(posts: posts);
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          SocialSearchStatusKey.posts.name,
        ], status: [
          Status.success,
        ]),
        values: socialSearch,
      ));
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            SocialSearchStatusKey.posts.name,
          ], status: [
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(
          Exception("SocialSearchBloc _searchPostMore error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          SocialSearchStatusKey.posts.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _clearSearch(
      ClearSearchEvent event, Emitter<SocialSearchState> emit) async {
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          SocialSearchStatusKey.global.name,
        ], status: [
          Status.idle,
        ]),
        search: "",
        values: const SocialSearchValue(posts: [], users: []),
      ),
    );
  }

  FutureOr<void> _resetSearch(
      ResetSearchEvent event, Emitter<SocialSearchState> emit) {
    emit(SocialSearchState(
      status: {
        SocialSearchStatusKey.global.name: Status.idle,
      },
    ));
  }
}
