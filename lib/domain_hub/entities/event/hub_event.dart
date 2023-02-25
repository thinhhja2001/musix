class HubEvent {
  const HubEvent();
}

class HubGetInfoEvent implements HubEvent {
  final String id;
  const HubGetInfoEvent(this.id);
}

class HubBackInfoEvent implements HubEvent {
  const HubBackInfoEvent();
}
