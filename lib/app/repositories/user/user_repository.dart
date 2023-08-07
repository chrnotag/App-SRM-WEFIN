import 'package:flutter_mobile_project/app/models/user_model.dart';

abstract class UserRepository {
  Future<void> register(String email, String password);

  Future<String> login(String email, String password);

  Future<UserModel> getUserLogged();

}
