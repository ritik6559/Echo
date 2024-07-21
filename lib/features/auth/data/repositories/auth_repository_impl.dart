import 'package:blog_app/core/error/excpetions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_base_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataBaseSource remoteDataBaseSource;

  AuthRepositoryImpl(
    this.remoteDataBaseSource,
  );
  @override
  Future<Either<Failure, User>> logInEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement logInEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataBaseSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerExcpetion catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }
}
