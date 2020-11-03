import 'package:flutter/material.dart';
import 'package:wifi_flutter/wifi_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'package:simple_permissions/simple_permissions.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _platformVersion = [];
  List _platformVersion2=[];
  List b=[];
  List ap1=[];
  List ap2=[];
  List ap3=[];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView.builder(
            itemBuilder: (context, i) => b[i], // convert it to label
            itemCount: b.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //
            ap1=[0];
            ap2=[0];
            ap3=[0];
            SimplePermissions.requestPermission(Permission.ReadExternalStorage);
            final noPermissions = await WifiFlutter.promptPermissions();
            if (noPermissions) {
              return;
            }
            for (var i = 0; i < 100; i++) {
              await Future.delayed(Duration(milliseconds: 100));

              final networks = await WifiFlutter.wifiNetworks;
              setState(() {
                _platformVersion = networks.map((network) {
                  return network.ssid;
                }).toList();
                _platformVersion2 = networks.map((network) {
                  return network.rssi;
                }).toList();


                //a.addAll(_platformVersion);
                print(_platformVersion);


                // select the name
                for (var ele_ind = 0; ele_ind <
                    _platformVersion.length; ele_ind++) {
                  //AP1
                  //print(_platformVersion[ele_ind].data);
                  if (_platformVersion[ele_ind] == 'tedata') {
                    print(_platformVersion2[ele_ind]);
                    ap1.add(_platformVersion2[ele_ind]);
                  }
                  //AP2
                  if (_platformVersion[ele_ind] == 'Orange-gogo gamal') {
                    print(_platformVersion2[ele_ind]);
                    ap2.add(_platformVersion2[ele_ind]);
                  }

                  //AP3
                  if (_platformVersion[ele_ind] == 'Basma') {
                    print(_platformVersion2[ele_ind]);
                    ap3.add(_platformVersion2[ele_ind]);
                  }
                }



                print('ap');
                //print(ap1);
                //print(ap2);
                //print(ap3);
              }


              );
            }
            //var json = jsonEncode(ap1, toEncodable: (e) => e.toJsonAttr());
            String rawJson = jsonEncode(ap1);
            print(rawJson);







          }),
    ));
  }
}