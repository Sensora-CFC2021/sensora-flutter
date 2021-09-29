class UserLogin {
  String username;
  String password;

  UserLogin({required this.username, required this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"username": this.username, "password": this.password};
}

class UserDetails {
  String username;
  String firstName;
  String lastName;
  String email;
  String password;

  UserDetails(
      {required this.username,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "first_name": this.firstName,
        "last_name": this.lastName,
        "email": this.email,
        "password": this.password,
      };
}

class UserSignup {
  String username;
  String firstName;
  String lastName;
  String email;
  String password;

  UserSignup(
      {required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.password});

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "first_name": this.firstName,
        "last_name": this.lastName,
        "email": this.email,
        "password": this.password,
      };
}

class Token {
  String token;

  Token({required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token']);
  }
}
