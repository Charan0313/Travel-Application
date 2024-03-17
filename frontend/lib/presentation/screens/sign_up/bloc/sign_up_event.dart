abstract class SignUpEvent {}

class SignUpTextChangedEvent extends SignUpEvent {
  final String emailValue;
  final String passwordValue;

  SignUpTextChangedEvent(
      {required this.emailValue, required this.passwordValue});
}

class SignUpSubmittedEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpSubmittedEvent({required this.email, required this.password});
}
