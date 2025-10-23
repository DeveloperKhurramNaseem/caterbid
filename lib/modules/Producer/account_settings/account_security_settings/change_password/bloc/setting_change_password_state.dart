part of 'setting_change_password_bloc.dart';

sealed class SettingChangePasswordState extends Equatable {
  const SettingChangePasswordState();
  
  @override
  List<Object> get props => [];
}

final class SettingChangePasswordInitial extends SettingChangePasswordState {}
