import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/domain_social/models/post/request/post_registry_model.dart';

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
  XFile? thumbnail;
  SocialAddPostThumbnailEvent(this.thumbnail);
}

class SocialAddPostDataSourceEvent extends SocialEvent {
  PlatformFile dataSource;
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
