abstract class SocialSearchEvent {
  const SocialSearchEvent();
}

class SearchAllSocialEvent implements SocialSearchEvent {
  final String query;
  const SearchAllSocialEvent(this.query);
}

class SearchMorePostEvent implements SocialSearchEvent {
  const SearchMorePostEvent();
}

class ClearSearchEvent implements SocialSearchEvent {
  const ClearSearchEvent();
}

class ResetSearchEvent implements SocialSearchEvent {}
