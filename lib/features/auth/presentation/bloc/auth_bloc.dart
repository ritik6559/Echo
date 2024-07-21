import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_log_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;

  AuthBloc({required UserSignUp userSignUp, required UserLogIn userLogIn})
      : _userSignUp = userSignUp,
        _userLogIn = userLogIn,
        super(
          AuthInitial(),
        ) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLognIn>(_onAuthLogIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (user) => emit(
        AuthSuccess(
          user: user,
        ),
      ),
    );
  }

  void _onAuthLogIn(AuthLognIn event, Emitter<AuthState> emit) async {
    final res = await _userLogIn(
      UserLogInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (user) => emit(
        AuthSuccess(user: user),
      ),
    );
  }
}
