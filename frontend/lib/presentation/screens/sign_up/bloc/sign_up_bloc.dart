import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:frontend/presentation/screens/sign_up/bloc/sign_up_event.dart';
import 'package:frontend/presentation/screens/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignUpError(errormessage: 'Please enter a valid email address'));
      } else if (event.passwordValue.length <= 6) {
        emit(SignUpError(
            errormessage:
                'Please enter a valid password with length greater than 6 characters'));
      } else {
        emit(SignUpValid());
      }
    });

    on<SignUpSubmittedEvent>((event, emit) {
      emit(SignUpLoading());
    });
  }
}
