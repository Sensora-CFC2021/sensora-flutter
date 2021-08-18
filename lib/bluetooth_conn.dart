import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sensora_test2/bottom_nav_bar.dart';
import 'package:sensora_test2/my_app_bar.dart';
import 'home_screen.dart';

class BluetoothConn extends StatefulWidget {
  BluetoothConn({Key? key}) : super(key: key);

  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  _BluetoothConnState createState() => _BluetoothConnState();
}

// hello
class _BluetoothConnState extends State<BluetoothConn> {
  late String value;

  BluetoothDevice? _connectedDevice;
  late List<BluetoothService> _services;

  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
        body: _buildView(),
        bottomNavigationBar: MyBottomNavBar(),
      );
  ListView _buildView() {
    return _buildListViewOfDevices();
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = <Container>[];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e != 'already_connected') {
                      print("already connected");
                    }
                  } finally {
                    _services = await device.discoverServices();
                  }
                  setState(() {
                    _connectedDevice = device;
                  });
                  _buildConnectDeviceView();
                },
              ),
              FlatButton(
                  onPressed: () async {
                    device.disconnect();
                  },
                  child: Text("Disconnect"))
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }
  // List<ButtonTheme> _buildReadWriteNotifyButton(
  //     BluetoothCharacteristic characteristic) {
  //   List<ButtonTheme> buttons = <ButtonTheme>[];

  //   if (characteristic.properties.read) {
  //     buttons.add(
  //       ButtonTheme(
  //         minWidth: 10,
  //         height: 20,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 4),
  //           child: RaisedButton(
  //             color: Colors.blue,
  //             child: Text('READ', style: TextStyle(color: Colors.white)),
  //             onPressed: () async {
  //               var sub = characteristic.value.listen((values) {
  //                 print(values);

  //                 setState(() {
  //                   widget.readValues[characteristic.uuid] = values;
  //                 });
  //               });
  //               await characteristic.write(utf8.encode("temp"));
  //               await characteristic.read();

  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => HomeScreen(value)));
  //               sub.cancel();
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return buttons;
  // }

  void _buildConnectDeviceView() {
    List<Container> containers = <Container>[];
    var lastService = _services[_services.length - 1];
    BluetoothCharacteristic characteristic = lastService.characteristics[0];
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(characteristic)));
    // for (BluetoothService service in _services) {
    //   List<Widget> characteristicsWidget = <Widget>[];

    //   for (BluetoothCharacteristic characteristic in service.characteristics) {
    //     if (widget.readValues[characteristic.uuid] == null) {
    //       widget.readValues[characteristic.uuid] = [];
    //     }
    //     value = utf8.decode(widget.readValues[characteristic.uuid]!);

    //     characteristicsWidget.add(
    //       Align(
    //         alignment: Alignment.centerLeft,
    //         child: Column(
    //           children: <Widget>[
    //             Row(
    //               children: <Widget>[
    //                 Text(characteristic.uuid.toString(),
    //                     style: TextStyle(fontWeight: FontWeight.bold)),
    //               ],
    //             ),
    //             Row(
    //               children: <Widget>[
    //                 ..._buildReadWriteNotifyButton(characteristic),
    //               ],
    //             ),
    //             Row(
    //               children: <Widget>[
    //                 Text('Value: '),
    //               ],
    //             ),
    //             Divider(),
    //           ],
    //         ),
    //       ),
    //     );
    //   }
    //   containers.add(
    //     Container(
    //       child: ExpansionTile(
    //           title: Text(service.uuid.toString()),
    //           children: characteristicsWidget),
    //     ),
    //   );
    // // }
    // return ListView(
    //   padding: const EdgeInsets.all(8),
    //   children: <Widget>[
    //     ...containers,
    //   ],
    // );
  }
}
