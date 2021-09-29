import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sensora_test2/bottom_nav_bar.dart';
import 'package:sensora_test2/my_app_bar.dart';
import 'home_screen.dart';
import 'user_info.dart';

class BluetoothConn extends StatefulWidget {
  BluetoothConn({Key? key}) : super(key: key);

  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  BluetoothConn({Key? key}) : super(key: key);
  
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
    FlutterBlue.instance.state.listen((state) {
      if (state == BluetoothState.off) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text("Turn on bluetooth !"),
              );
            });
      } else {
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
    });
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
        drawer: UserInfo(),
        appBar: MyAppBar(),
        body: _buildView(),
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
                    // ignore: unrelated_type_equality_checks
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

  void _buildConnectDeviceView() {
    var lastService = _services[_services.length - 1];
    BluetoothCharacteristic characteristic = lastService.characteristics[0];
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(characteristic)));
  }
}
