import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
      appBar: AppBar(
        title: Text('Choose your Language'),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        bottom: PreferredSize(
            child: Container(
              child: Text("000000000000000000000000000000000"),
              color: Colors.grey,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/back_button.svg",
              height: 26,
              width: 26,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [builSingleCheckBox(), builSingleCheckBox1()],
    );
  }

  Widget builSingleCheckBox() => CheckboxListTile(
        title: const Text('English'),
        value: timeDilation != 1.0,
        onChanged: (bool? value) {
          setState(() {
            timeDilation = value! ? 10.0 : 1.0;
          });
        },
        secondary: SvgPicture.asset(
          "assets/icons/uk.svg",
          height: 26,
          width: 26,
        ),
      );
  Widget builSingleCheckBox1() => CheckboxListTile(
        title: const Text('Mongolian'),
        value: timeDilation != 1.0,
        onChanged: (bool? value) {
          setState(() {
            timeDilation = value! ? 10.0 : 1.0;
          });
        },
        secondary: SvgPicture.asset(
          "assets/icons/mongolia.svg",
          height: 26,
          width: 26,
        ),
      );
}
