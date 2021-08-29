import 'package:flutter/material.dart';
import 'package:sensora_test2/weather_screen.dart';
import '../bottom_nav_bar.dart';
import 'custom_checkbox.dart';
import '../utils/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new SurveyWidget());

class SurveyWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SurveyScreen(title: 'GridView with Search'),
    );
  }
}

class SurveyScreen extends StatefulWidget {
  SurveyScreen({required this.title});
  final String title;

  @override
  _SurveyScreenState createState() => new _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  TextEditingController editingController = TextEditingController();
  List<String> selectedItems = [];
  final List<Map<String, dynamic>> _allVegies = allVegies;
  List<Map<String, dynamic>> items = [];
  late SharedPreferences vegiesData;
  late bool newLogin;
  late bool select;

  @override
  void initState() {
    items = _allVegies;
    super.initState();
    check_Login();
  }

  // ignore: non_constant_identifier_names
  void check_Login() async {
    vegiesData = await SharedPreferences.getInstance();
    newLogin = (vegiesData.getBool('login') ?? true);
    if (!newLogin) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WeatherApp()));
      print("Newtersen bn" + " --> ");
    }
  }

  void filterSearchResults(String query) {
    List<Map<String, dynamic>> dummySearchList = [];
    if (query.isEmpty) {
      dummySearchList = _allVegies;
    } else {
      dummySearchList = _allVegies.where((element) {
        if (element["name"].toLowerCase().contains(query.toLowerCase()))
          return true;
        return element["isSelected"];
      }).toList();
    }
    setState(() {
      items = dummySearchList;
    });
  }

  void onCheckBox(int vegieId, bool isSelected) {
    List<Map<String, dynamic>> selItem =
        _allVegies.where((element) => element["id"] == vegieId).toList();
    vegiesData.setBool('selected', isSelected);
    setState(() {
      _allVegies[_allVegies.indexOf(selItem[0])]["isSelected"] = isSelected;
    });
    isSelected
        ? selectedItems.add(vegieId.toString())
        : selectedItems.remove(vegieId);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                  flex: 15,
                  child: items.length > 0
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              key: ValueKey(items[index]['id']),
                              padding: const EdgeInsets.all(8),
                              child: CustomCheckBox(
                                iconPath: items[index]['image'].toString(),
                                vegieName: items[index]['name'].toString(),
                                vegieId: items[index]['id'],
                                isSelect: items[index]['isSelected'],
                                onCheck: onCheckBox,
                              ),
                              color: Colors.white,
                            );
                          },
                        )
                      : Text('Хайлт олдсонгүй',
                          style: TextStyle(fontSize: 20))),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            vegiesData.setStringList(
                                'selectedList', selectedItems.toSet().toList());
                            vegiesData.setBool('login', false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WeatherApp()));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                          child: Text("Үргэжлүүлэх",
                              style: TextStyle(fontSize: 25)))
                    ],
                  ))
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar());
  }
}
