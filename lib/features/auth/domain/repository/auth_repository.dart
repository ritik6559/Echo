import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> logInEmailPassword({
    required String email,
    required String password,
  });

  
}
