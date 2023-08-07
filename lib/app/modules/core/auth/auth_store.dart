// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_mobile_project/app/core/helpers/constants.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_mobile_project/app/core/local_storage/local_storage.dart';
import 'package:flutter_mobile_project/app/models/user_model.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalStorage _localStorage;

  @readonly
  UserModel? _userLogged;

  AuthStoreBase({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  @action
  Future<void> loadUserLogged() async {
    // Usuário Logado!!!
    final userModelJson = await _localStorage
        .read<String>(Constants.LOCAL_STORAGE_USE_LOGGED_DATA_KEY);

    if (userModelJson != null) {
      _userLogged = UserModel.fromJson(userModelJson);
    } else {
      _userLogged = UserModel.empty();
    }
  }

  @action
  Future<void> logout() async {
    await _localStorage.clear();
    _userLogged = UserModel.empty();
  }
}
