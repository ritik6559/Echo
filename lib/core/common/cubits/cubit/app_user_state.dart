part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;

  AppUserLoggedIn({
    required this.user,
  });
}

//core cannot depend on other features.
//other features can depend on core.
//therefore we move entities from domain to common.
//there is no compulsion that dommain should contain entities.
