import 'package:flutter/material.dart';

import '/login/user_repository.dart';
import '/login/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.width * 0.22,
      padding: EdgeInsets.only(top: 30),
      child: RaisedButton(
        child: Text('Create an Account', style: TextStyle(fontSize: 20)),
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return RegisterScreen(userRepository: _userRepository);
            }),
          );
        },
      ),
    );
  }
}
