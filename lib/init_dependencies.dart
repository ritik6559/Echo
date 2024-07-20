import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_base_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase
      .client); //registerLzySingleton because we want the same instance thorughout the app.
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataBaseSource>(//type of data that we are returning.registerFactory because we always need a new instanc of authRepository.
    () => AuthRemoteDataBaseSourceImpl(
      supabaseClient:
          serviceLocator(), //it looks for the dependency that has the same type as supabase client.
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataBaseSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
