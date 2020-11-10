import 'package:flutter/material.dart';
import 'package:wifi_flutter/wifi_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart'; //add path provider dart plugin on pubspec.yaml file
import 'package:permission_handler/permission_handler.dart';
import 'main.dart';

void main() {
  runApp(Screen2());
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() {
    return _Screen2State();
  }
}

class _Screen2State extends State<Screen2> {
  List _platformVersion = [];
  List _platformVersion2 = [];
  List results = [];
  List ap1 = [];
  List ap2 = [];
  List ap3 = [];
  var i = 0;
  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('RSSI Collector'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text(
              'Enter Your Area Name !',
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: TextField(
              maxLengthEnforced: true,
              decoration: InputDecoration(
                hintText: 'Example: Area01',
                hintStyle: TextStyle(fontSize: 13),
                icon: Icon(
                  Icons.add_location_rounded,
                  color: Colors.white,
                  size: 35,
                ),
                prefixIcon: Icon(
                  Icons.keyboard,
                  // color: Colors.teal,
                ),
                prefixText: 'Area: ',
                prefixStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.grey[300],
                labelText: 'Area Name',
                labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                suffix: Container(
                  width: 5,
                  height: 5,
                  color: Colors.teal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              // autofocus: true,
              maxLength: 10,
              cursorHeight: 30,
              cursorColor: Colors.teal,
              controller: myController,
            ),
          ),
          FlatButton(
              // minWidth: 150,
              height: 50,
              color: Colors.teal,
              child: Text(
                'Scan',
                style: TextStyle(
                  inherit: true,
                  // fontFamily: 'BebasNeue',
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              // child: Icon(
              //   Icons.search,
              //   size: 50,
              //   color: Colors.white,
              // ),
              onPressed: () async {
                print((myController.text));
                //
                ap1 = [0];
                ap2 = [0];
                ap3 = [0];
                results = [0];
                //await Permission.contacts.request()

// code of read or write file in external storage (SD card)

                final noPermissions = await WifiFlutter.promptPermissions();
                if (noPermissions) {
                  return;
                }
                for (i = 0; i <= 50; i++) {
                  await Future.delayed(Duration(milliseconds: 100));

                  final networks = await WifiFlutter.wifiNetworks;
                  setState(() {
                    // Text('Scanning...');
                    _platformVersion = networks.map((network) {
                      return network.ssid;
                    }).toList();
                    _platformVersion2 = networks.map((network) {
                      return network.rssi;
                    }).toList();

                    //a.addAll(_platformVersion);
                    print(_platformVersion);

                    // select the name
                    for (var eleInd = 0;
                        eleInd < _platformVersion.length;
                        eleInd++) {
                      //AP1
                      //print(_platformVersion[ele_ind].data);
                      if (_platformVersion[eleInd] == 'tedata') {
                        print(_platformVersion2[eleInd]);
                        ap1.add(_platformVersion2[eleInd]);
                      }
                      //AP2
                      if (_platformVersion[eleInd] == 'Orange-gogo gamal') {
                        print(_platformVersion2[eleInd]);
                        ap2.add(_platformVersion2[eleInd]);
                      }

                      //AP3
                      if (_platformVersion[eleInd] == 'Basma') {
                        print(_platformVersion2[eleInd]);
                        ap3.add(_platformVersion2[eleInd]);
                      }
                    }

                    print('ap');
                    print(ap1);
                    print(_platformVersion.length);
                    print(i);
                    //print(ap2);
                    //print(ap3);
                  });
                }

                //var json = jsonEncode(ap1, toEncodable: (e) => e.toJsonAttr());
                //String rawJson = jsonEncode(ap1);
                //print(rawJson);
                //File('/data/user/0/com.example.flutter_appf/assets/sayed.txt').writeAsString('$ap1');

                //Future<String> loadAsset() async {
                //return await rootBundle.loadString('assets/sayed.txt');
                //  }

                print((myController.text));

                Directory tempDir = main.path;
                // Directory tempDir = await getApplicationDocumentsDirectory();

                String tempPath = tempDir.path;
                print(tempPath);
                results.addAll([ap1, ap2, ap3]);

                File f1 = new File('s1.txt');
                File file = new File(tempPath + "/" + '.txt');
                file.createSync();
                var nameOfArea = myController.text;
                File(tempPath + "/" + '$nameOfArea' + '.txt')
                    .writeAsString('$results');
                String contents = await file.readAsString();
                var status = await Permission.storage.status;
                if (!status.isGranted) {
                  await Permission.storage.request();
                }

                print(contents);
              }),
          Padding(
            padding: const EdgeInsets.only(top: 75),
            child: Text(
              '$i Samples Has Been Scanned!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
