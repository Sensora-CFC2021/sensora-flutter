import 'package:flutter/material.dart';
import 'package:sensora_test2/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef VoidNavigate = void Function(
  int vegieId,
  bool isSelected,
);

// ignore: must_be_immutable
class CustomCheckBox extends StatefulWidget {
  String iconPath;
  String vegieName;
  int vegieId;
  bool isSelect;
  VoidNavigate onCheck;

  CustomCheckBox({
    required this.vegieId,
    required this.iconPath,
    required this.vegieName,
    required this.isSelect,
    required this.onCheck,
  });

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _isSelected;
  late String pathIcon;
  late String vegieName;
  late int vegieId;
  List<String> selectedVegies = [];
  late SharedPreferences vegiesCheck;

  @override
  void initState() {
    _isSelected = widget.isSelect;
    pathIcon = widget.iconPath;
    vegieName = widget.vegieName;
    vegieId = widget.vegieId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onCheck(vegieId, _isSelected);
        });
      },
      child: Container(
          child: Card(
              elevation: 5,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                    color: _isSelected ? Colors.transparent : Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: _isSelected
                        ? null
                        : Border.all(
                            color: Colors.transparent,
                            width: 1.5,
                          )),
                child: _isSelected
                    ? Stack(
                        children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(color: Colors.white),
                            alignment: Alignment.center,
                            height: 240,
                            child: Image.asset(
                              pathIcon,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            color: Colors.black54,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.check,
                              size: 100,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    : Image.asset(
                        pathIcon,
                        fit: BoxFit.contain,
                      ),
              ))),
    );
  }
}
