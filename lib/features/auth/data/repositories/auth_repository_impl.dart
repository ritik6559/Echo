import 'package:blog_app/core/error/excpetions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_base_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataBaseSource remoteDataBaseSource;

  AuthRepositoryImpl(
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
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(
        Failure(e.message),
      );
    } on ServerExcpetion catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataBaseSource.getCurrentUserData();
      if (user == null) {
        return Left(
          Failure('User not found'),
        );
      }
      return right(user);
    } on ServerExcpetion catch (e) {
      return Left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
