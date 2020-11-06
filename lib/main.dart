// import 'dart:html';
import 'package:flutter/material.dart';
import 'screen2.dart';

void main() {
  runApp(MaterialApp(
    home: Screen1(),
  ));
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text('RSSI Collector'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Welcome !',
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 80,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: RaisedButton(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Start\nScanning',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Screen2()),
                    );
                  }),
            ),
          )
        ],
      ),
    ));
  }
}
