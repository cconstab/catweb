class ActiveRadios {
  String radioUuid;
  bool active;

  ActiveRadios({
    required this.radioUuid,
    this.active = false,
  });

  void activeRadio(bool activate) {
    active = activate;
  }

}
