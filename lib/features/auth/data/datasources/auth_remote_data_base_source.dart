import 'package:blog_app/core/error/excpetions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataBaseSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataBaseSourceImpl implements AuthRemoteDataBaseSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataBaseSourceImpl(
    this.supabaseClient,
  );

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      if (res.user == null) {
        throw ServerExcpetion(message: 'User not found!');
      }
      return UserModel.fromJson(res.user!.toJson()).copyWith(
        email: currentUserSession!.user.email,
      );
    } catch (e) {
      throw ServerExcpetion(
        message: e.toString(),
      );
    }
  }
  
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            ); //select gives us all the values, eq means equals to we are getting that users data whose id is equal to current user id.
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      } else {
        return null;
      }
    } catch (e) {
      throw ServerExcpetion(
        message: e.toString(),
      );
    }
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
      return UserModel.fromJson(res.user!.toJson()).copyWith(
        email: currentUserSession!.user.email,
      );
    } catch (e) {
      throw ServerExcpetion(
        message: e.toString(),
      );
    }
  }
}
