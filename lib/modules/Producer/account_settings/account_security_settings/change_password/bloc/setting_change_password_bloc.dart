import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setting_change_password_event.dart';
part 'setting_change_password_state.dart';

class SettingChangePasswordBloc extends Bloc<SettingChangePasswordEvent, SettingChangePasswordState> {
  SettingChangePasswordBloc() : super(SettingChangePasswordInitial()) {
    on<SettingChangePasswordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
