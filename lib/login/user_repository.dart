import 'dart:async';
import 'user_model.dart';
import 'package:meta/meta.dart';
import 'api_model.dart';
import 'api_connection.dart';
import 'user_dao.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    required String username,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> signUp({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    UserSignup userSignup = UserSignup(
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
      username: userName,
    );

    UserLogin registeredUser = await registerUser(userSignup);
    Token registeredUserToken = await getToken(registeredUser);
    User user = User(
      id: 0,
      username: userName,
      token: registeredUserToken.token,
    );
    await userDao.createUser(user);
  }

  Future<void> persistToken({required User user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> deleteToken({required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}
