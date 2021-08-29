import 'package:flutter/material.dart';
import 'package:sensora_test2/constant.dart';

typedef VoidNavigate = void Function(String name, bool isSelected, int vegieId);

class CustomCheckBox extends StatefulWidget {
  String iconPath;
  String vegieName;
  int vegieId;

  VoidNavigate onCheck;

  CustomCheckBox({
    required this.vegieId,
    required this.iconPath,
    required this.vegieName,
    required this.onCheck,
  });

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isSelected = false;
  late String pathIcon;
  late String vegieName;
  late int vegieId;
  List<String> selectedVegies = [];

  @override
  void initState() {
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
          widget.onCheck(vegieName, _isSelected, vegieId);
        });
      },
      child: Container(
          child: Card(
              elevation: 5,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                    color: _isSelected
                        ? Colors.black.withOpacity(0.3)
                        : Colors.white,
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
