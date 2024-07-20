import 'package:blog_app/core/error/excpetions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_base_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataBaseSource remoteDataBaseSource;

  AuthRepositoryImpl({
    required this.remoteDataBaseSource,
  });
  @override
  Future<Either<Failure, String>> logInEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement logInEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataBaseSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerExcpetion catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }
}
