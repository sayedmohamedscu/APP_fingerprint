import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; //add path provider dart plugin on pubspec.yaml file
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'screen2.dart';
import 'screen2.dart';

void main() {
  runApp(MaterialApp(
    home: CreateApp(),
  ));
}

/// This is the main application widget.
class CreateApp extends StatefulWidget {
  static Directory folderPath;

  @override
  _CreateAppState createState() => _CreateAppState();
}

class _CreateAppState extends State<CreateApp> {
  var _name;
  final nameCon = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Rssi Collector'),
            backgroundColor: Colors.blueGrey,
          ),
          body: Builder(builder: (context){
            return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter the Project name',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      TextField(
                        controller: nameCon,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter the project name'),
                      ),
                      RaisedButton(
                          child: Text('create project'),
                          onPressed: () async{

                            final folderName=nameCon.text;
                            final path= new Directory("storage/emulated/0/$folderName");
                            if ((await path.exists())){
                              Scaffold.of(context)
                                  .showSnackBar(SnackBar(content: Text('Project name is exist')));
                            }
                            else {
                              var status = await Permission.storage.status;
                              if (!status.isGranted) {
                                await Permission.storage.request();
                              }
                              path.create();
                              Scaffold.of(context)
                                  .showSnackBar(SnackBar(content: Text('Project created')));
                              await Future.delayed(Duration(milliseconds: 1500));
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Screen2()),
                              );
                            }
                            setState((){
                              folderPath = Directory("storage/emulated/0/$folderName");
                            });



                          })
                    ],
                  ),
                ));
          },)
      ),
    );
  }
}

// class NoOfRegion extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text('Rssi Collector'),
//           backgroundColor: Colors.blueGrey,
//         ),
//         body: Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [Region()],
//               ),
//             )),
//       ),
//     );
//   }
// }
//
// class Region extends StatefulWidget {
//   @override
//   _RegionState createState() => _RegionState();
// }
//
// class _RegionState extends State<Region> {
//   var _number1;
//   final numberCon1 = new TextEditingController();
//   var _number2;
//   final numberCon2 = new TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Please enter number of regions",
//             style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87),
//           ),
//           TextFormField(
//             controller: numberCon1,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter a value  between 1 ~ 5'),
//             validator: (value) {
//               if (int.parse(value) > 5 || int.parse(value) < 1) {
//                 return 'Only 1~5 number of regions is allowed';
//               } else if (value.isEmpty) {
//                 return 'Please insert a number 1~5';
//               }
//               return null;
//             },
//           ),
//           Text("Please enter the number of samples",
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87)),
//           TextFormField(
//             controller: numberCon2,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter a value  between 10s ~ 30s'),
//             validator: (value) {
//               if (int.parse(value) > 30 || int.parse(value) < 10) {
//                 return 'Only 10~30 number of regions is allowed';
//               } else if (value.isEmpty) {
//                 return 'Please insert a number 1~5';
//               }
//               return null;
//             },
//           ),
//           RaisedButton(
//             onPressed: () async{
//               if (_formKey.currentState.validate()) {
//                 // If the form is valid, display a Snackbar.
//                 Scaffold.of(context)
//                     .showSnackBar(SnackBar(content: Text('Processing Data')));
//
//               }
//               setState(() {
//                 _number1 = numberCon1.text;
//                 _number2 = numberCon2.text;
//               });
//               await Future.delayed(Duration(milliseconds: 1500));
//               if (int.parse(_number1) == 1 ){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => one_region()),
//                 );  }
//               else if (int.parse(_number1) == 2 ){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => two_region()),
//                 );  }
//               else if (int.parse(_number1) == 3 ){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => three_region()),
//                 );  }
//               else if (int.parse(_number1) == 4 ){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => four_region()),
//                 );  }
//               else if (int.parse(_number1) == 5 ){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => five_region()),
//                 );  }
//
//             },
//
//             child: Text('create regions'),
//           ),
//           Text(
//               'The number of regions is ($_number1) and the number of samples ($_number2)')
//         ],
//       ),
//     );
//   }
// }
//
// class one_region extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Rssi Collector'), backgroundColor: Colors.blueGrey,),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               RaisedButton(child: Text('Region one'),onPressed: null),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// class two_region extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Rssi Collector'), backgroundColor: Colors.blueGrey,),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               RaisedButton(child: Text('Region one'),onPressed: null),
//               Container(padding:const EdgeInsets.all(15.0) ,),
//               RaisedButton(child: Text('Region two'),onPressed: null),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// class three_region extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Rssi Collector'), backgroundColor: Colors.blueGrey,),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               RaisedButton(child: Text('Region one'),onPressed: null),
//               Container(padding:const EdgeInsets.all(15.0) ,),
//               RaisedButton(child: Text('Region two'),onPressed: null),
//             ],
//           ),
//           Row(
//             children: [
//               RaisedButton(child: Text('Region three'),onPressed: null),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
// class four_region extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Rssi Collector'), backgroundColor: Colors.blueGrey,),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               RaisedButton(child: Text('Region one'),onPressed: null),
//               Container(padding:const EdgeInsets.all(15.0) ,),
//               RaisedButton(child: Text('Region two'),onPressed: null),
//             ],
//           ),
//           Row(
//             children: [
//               RaisedButton(child: Text('Region three'),onPressed: null),
//               Container(padding:const EdgeInsets.all(15.0) ,),
//               RaisedButton(child: Text('Region four'),onPressed: null),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// class five_region extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Rssi Collector'), backgroundColor: Colors.blueGrey,),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               RaisedButton(child: Text('Region one'),onPressed: null),
//               Container(padding:const EdgeInsets.all(15.0) ,),
//               RaisedButton(child: Text('Region two'),onPressed: null),
//             ],
//           ),
//           Row(
//             children: [
//               RaisedButton(child: Text('Region three'),onPressed: null),
//               Container(padding:const EdgeInsets.all(15.0) ,),
//               RaisedButton(child: Text('Region four'),onPressed: null),
//             ],
//
//           ),
//           Row(
//             children: [
//               RaisedButton(child: Text('Region five'),onPressed: null),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }