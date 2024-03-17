abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpValid extends SignUpState {}

class SignUpError extends SignUpState {
  final String errormessage;
  SignUpError({required this.errormessage});
}

class SignUpLoading extends SignUpState {}
