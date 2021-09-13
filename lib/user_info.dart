import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensora_test2/login/login_page.dart';
import 'package:sensora_test2/main.dart';
import 'login/bloc/authentication_bloc.dart';
import 'login/user_repository.dart';

class UserInfo extends StatelessWidget {
  var userRepository = UserRepository();
  UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Username"),
            accountEmail: Text("Email"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                size: 72,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Username"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Firstname"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text("Lastname"),
            onTap: () => null,
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("LogOut"),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyApp(userRepository: userRepository)));
              }),
        ],
      ),
    );
  }
}
