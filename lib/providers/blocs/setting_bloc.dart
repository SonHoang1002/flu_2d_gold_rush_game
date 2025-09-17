import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldrush_2d/providers/events/setting_event.dart';
import 'package:goldrush_2d/providers/states/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingStateInit()) {
    on<SettingEventInit>((event, emit) {});
    on<SettingEventUpdateVolumn>((event, emit) {
      emit(SettingStateUpdate(isMute: state.isMute, volumn: event.volumn));
    });
    on<SettingEventUpdateMute>((event, emit) {
      emit(SettingStateUpdate(isMute: event.isMute, volumn: state.volumn));
    });
  }
}
