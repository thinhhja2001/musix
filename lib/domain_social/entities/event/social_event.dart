import 'package:image_picker/image_picker.dart';

import '../state/social_state.dart';

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

class SocialAddCreatePostThumbnailEvent extends SocialEvent {
  XFile? thumbnail;
  SocialAddCreatePostThumbnailEvent(this.thumbnail);
}
