part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final bool isValidLength;
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumberOrSymbol;
  final bool isPasswordValid;
  final bool isButtonEnabled;
  final bool isLoading;
  final String? errorMessage;

  const ChangePasswordState({
    this.isValidLength = false,
    this.hasUpperCase = false,
    this.hasLowerCase = false,
    this.hasNumberOrSymbol = false,
    this.isPasswordValid = false,
    this.isButtonEnabled = false,
    this.isLoading = false,
    this.errorMessage,
  });

  ChangePasswordState copyWith({
    bool? isValidLength,
    bool? hasUpperCase,
    bool? hasLowerCase,
    bool? hasNumberOrSymbol,
    bool? isPasswordValid,
    bool? isButtonEnabled,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      isValidLength: isValidLength ?? this.isValidLength,
      hasUpperCase: hasUpperCase ?? this.hasUpperCase,
      hasLowerCase: hasLowerCase ?? this.hasLowerCase,
      hasNumberOrSymbol: hasNumberOrSymbol ?? this.hasNumberOrSymbol,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isValidLength,
        hasUpperCase,
        hasLowerCase,
        hasNumberOrSymbol,
        isPasswordValid,
        isButtonEnabled,
        isLoading,
        errorMessage,
      ];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}
