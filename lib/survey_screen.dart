import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'bottom_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'my_app_bar.dart';

class SurveyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Body(),
        bottomNavigationBar: MyBottomNavBar());
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<Body> {
  bool _isSelected = false;
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.all(15),
          child: Text(
            AppLocalizations.of(context)!.select_plants,
            style: TextStyle(fontSize: 24),
          ),
        ),
        new Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              CheckboxListTile(
                title: IconButton(
                  icon: SvgPicture.asset("assets/icons/potato.svg"),
                  onPressed: () {},
                ),
                subtitle: Text("Төмс"),
                value: _isSelected,
                onChanged: (value) {
                  setState(() {
                    _isSelected = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: IconButton(
                  icon: SvgPicture.asset("assets/icons/potato.svg"),
                  onPressed: () {},
                ),
                subtitle: Text("Лууван"),
                value: _isSelected,
                onChanged: (value) {
                  setState(() {
                    _isSelected = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: IconButton(
                  icon: SvgPicture.asset("assets/icons/potato.svg"),
                  onPressed: () {},
                ),
                subtitle: Text("Манжин"),
                value: _isSelected,
                onChanged: (value) {
                  setState(() {
                    _isSelected = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: IconButton(
                  icon: SvgPicture.asset("assets/icons/potato.svg"),
                  onPressed: () {},
                ),
                subtitle: Text("Сонгино"),
                value: _isSelected,
                onChanged: (value) {
                  setState(() {
                    _isSelected = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: IconButton(
                  icon: SvgPicture.asset("assets/icons/potato.svg"),
                  onPressed: () {},
                ),
                subtitle: Text("Сармис"),
                value: _isSelected,
                onChanged: (value) {
                  setState(() {
                    _isSelected = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: IconButton(
                  icon: SvgPicture.asset("assets/icons/potato.svg"),
                  onPressed: () {},
                ),
                subtitle: Text("Манжин"),
                value: _isSelected,
                onChanged: (value) {
                  setState(() {
                    _isSelected = value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
