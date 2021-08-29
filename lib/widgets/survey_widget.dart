import 'package:flutter/material.dart';
import 'package:sensora_test2/home_screen.dart';
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
      home: new MyHomePage(title: 'GridView with Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();

  List<String> selectedItems = [];

  final List<Map<String, dynamic>> _allVegies = allVegies;

  List<Map<String, dynamic>> items = [];

  late SharedPreferences vegiesData;

  late bool newLogin;

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
    if (newLogin == false) {
      print("Newtersen bn");
    }
  }

  void filterSearchResults(String query) {
    List<Map<String, dynamic>> dummySearchList = [];
    if (query.isEmpty) {
      dummySearchList = _allVegies;
    } else {
      dummySearchList = _allVegies
          .where((element) =>
              element["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      items = dummySearchList;
    });
  }

  void onCheckBox(String name, bool isSelected, int vegieId) {
    print(name +
        "-- is sel" +
        isSelected.toString() +
        ",  " +
        "veg id-->" +
        vegieId.toString());

    if (isSelected == true) {
      selectedItems.add(vegieId.toString());
    } else {
      selectedItems.remove(vegieId);
    }
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
                                'selectedList', selectedItems);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
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
