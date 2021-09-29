import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sensora_test2/user_info.dart';
import 'api_model.dart';

final _base = "https://young-dawn-73987.herokuapp.com";
final _tokenEndpoint = "/api-token-auth/";
final _signUpEndpoint = "/api/user/";
final _tokenURL = _base + _tokenEndpoint;
final _signUpUrl = _base + _signUpEndpoint;

final _adminUsername = "yesukhei";
final _adminPassword = "heroku123";

Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await http.post(
    Uri.parse(_tokenURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  print(_tokenURL);
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    //print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> getAdminToken() async {
  final UserLogin admin =
      UserLogin(username: _adminUsername, password: _adminPassword);
  final Token token = await getToken(admin);
  return token.token.toString();
}

Future<UserLogin> registerUser(UserSignup userSignup) async {
  final String adminToken = await getAdminToken();
  final http.Response response = await http.post(
    Uri.parse(_signUpUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $adminToken'
    },
    body: jsonEncode(userSignup.toDatabaseJson()),
  );

  print(adminToken);
  if (response.statusCode == 201) {
    final UserLogin user =
        UserLogin(username: userSignup.username, password: userSignup.password);

    return user;
  } else {
    print("hello");
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
