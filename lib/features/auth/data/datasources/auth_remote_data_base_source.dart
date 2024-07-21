import 'package:blog_app/core/error/excpetions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataBaseSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataBaseSourceImpl implements AuthRemoteDataBaseSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataBaseSourceImpl(
    this.supabaseClient,
  );

  @override
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  }) {
    //TODO: implement loginwith email password
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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
      return UserModel.fromJson(res.user!.toJson());
    } catch (e) {
      throw ServerExcpetion(
        message: e.toString(),
      );
    }
  }
}
