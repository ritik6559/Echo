import 'package:blog_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_log_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogIn = userLogIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(
          AuthInitial(),
        ) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLognIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
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
      (user) => _emitAuthSuccess(user,emit),
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
      (user) => _emitAuthSuccess(user,emit),
    );
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(
        AuthFailure(
          message: l.message,
        ),
      ),
      (user) => _emitAuthSuccess(user,emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(user: user),
    );
  }
}
