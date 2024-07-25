import 'package:blog_app/core/error/excpetions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_base_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataBaseSource remoteDataBaseSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(
    this.connectionChecker,
    this.remoteDataBaseSource,
  );
  @override
  Future<Either<Failure, User>> logInEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataBaseSource.logInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataBaseSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return Left(
          Failure('No Internet connection'),
        );
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(
        Failure(e.message),
      );
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataBaseSource.currentUserSession;

        if (session == null) {
          return Left(
            Failure(
              'User not logged in',
            ),
          );
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }

      final user = await remoteDataBaseSource.getCurrentUserData();

      if (user == null) {
        return Left(
          Failure('Log In First'),
        );
      }
      return right(user);
    } on ServerException catch (e) {
      return Left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
