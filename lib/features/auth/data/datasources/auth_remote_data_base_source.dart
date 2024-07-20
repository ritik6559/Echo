import 'package:blog_app/core/error/excpetions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataBaseSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> logInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataBaseSourceImpl implements AuthRemoteDataBaseSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataBaseSourceImpl({
    required this.supabaseClient,
  });

  @override
  Future<String> logInWithEmailPassword({
    required String email,
    required String password,
  }) {
    //TODO: implement loginwith email password
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        'name': name,
      });
      if (res.user == null) {
        throw ServerExcpetion(message: 'User is null!');
      }
      return res.user!.id;
    } catch (e) {
      throw ServerExcpetion(
        message: e.toString(),
      );
    }
  }
}
