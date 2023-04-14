import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/post/request/post_registry_model.dart';

import '../post/post.dart';

class SocialEvent {}

class SocialGetPostEvent extends SocialEvent {
  String postId;

  SocialGetPostEvent(this.postId);
}

class SocialGetCommentsByPostIdEvent extends SocialEvent {
  String postId;
  SocialGetCommentsByPostIdEvent(this.postId);
}

class SocialGetListPostJustForYouEvent extends SocialEvent {
  SocialGetListPostJustForYouEvent();
}

class SocialGetListPostTrendingEvent extends SocialEvent {
  SocialGetListPostTrendingEvent();
}

class SocialGetListPostFollowingEvent extends SocialEvent {
  SocialGetListPostFollowingEvent();
}

class SocialAddPostThumbnailEvent extends SocialEvent {
  File? thumbnail;
  SocialAddPostThumbnailEvent(this.thumbnail);
}

class SocialAddPostDataSourceEvent extends SocialEvent {
  File dataSource;
  SocialAddPostDataSourceEvent(this.dataSource);
}

class SocialCreatePostEvent extends SocialEvent {
  PostRegistryModel postRegistryModel;
  SocialCreatePostEvent(this.postRegistryModel);
}

class SocialRemovePostThumbnailEvent extends SocialEvent {}

class SocialRemovePostDataSourceEvent extends SocialEvent {}

class SocialCreatePostBackEvent extends SocialEvent {}

class SocialUpdateCreatePostStatus extends SocialEvent {
  int? status;
  SocialUpdateCreatePostStatus(this.status);
}

class SocialModifyPostEvent extends SocialEvent {
  PostRegistryModel postRegistryModel;
  String postId;
  SocialModifyPostEvent({
    required this.postRegistryModel,
    required this.postId,
  });
}

class SocialUpdateModifyPostStatus extends SocialEvent {
  int? status;
  SocialUpdateModifyPostStatus(this.status);
}

class SocialModifyPostBackEvent extends SocialEvent {}

class SocialLikeOrDislikePostEvent extends SocialEvent {
  String postId;
  SocialLikeOrDislikePostEvent(this.postId);
}

class SocialDeletePostEvent extends SocialEvent {
  Post post;
  SocialDeletePostEvent(this.post);
}
