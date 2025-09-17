abstract class SettingEvent {}

class SettingEventInit extends SettingEvent {
  final double volumn;
  final bool isMute;
  SettingEventInit({required this.volumn, required this.isMute}) : super();
}

class SettingEventUpdateVolumn extends SettingEvent {
  final double volumn;
  SettingEventUpdateVolumn({required this.volumn}) : super();
}

class SettingEventUpdateMute extends SettingEvent {
  final bool isMute;
  SettingEventUpdateMute({required this.isMute}) : super();
}
