abstract class SettingState {
  final double volumn;
  final bool isMute;
  SettingState({required this.volumn, required this.isMute});
}

class SettingStateInit extends SettingState {
  SettingStateInit() : super(volumn: 50, isMute: true);
}

class SettingStateUpdate extends SettingState {
  final double volumn;
  final bool isMute;
  SettingStateUpdate({required this.isMute, required this.volumn})
    : super(isMute: isMute, volumn: volumn);
}
