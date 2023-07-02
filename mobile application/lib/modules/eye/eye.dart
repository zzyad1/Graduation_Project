// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class eye extends StatefulWidget {
//
//   @override
//   State<eye> createState() => _eyeState();
// }
//
// class _eyeState extends State<eye> {
//   bool direction = true;
//   var forword;
//   var back;
//   var left;
//   var right;
//   List<String> buttom = ['forword','back','left','right'];
//   var counter = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       child: Column(
//         children:
//         [
//           Expanded(
//               child: MaterialButton(
//                 onPressed: ()
//                 {
//                   setState(() {
//                     counter=0;
//                     buttom[counter];
//                 }); },
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Container(
//                     key: forword,
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: counter == 0 ? Colors.teal : Colors.grey[300],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Forword',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25.0,
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         Icon(Icons.arrow_upward_rounded,size: 70.0,)
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: MaterialButton(
//                       onPressed: () {
//                         setState(() {
//                           counter=2;
//                           buttom[counter];
//                         });
//                       },
//                       child:Container(
//                         key: left,
//                         width: 200,
//                         height: 200,
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children:[
//                               Icon(Icons.arrow_back_rounded,
//                                 size: 70.0,
//                               ),
//                               SizedBox(
//                                 height: 15.0,
//
//                               ),
//                               Text('left',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25.0,
//                                 ),
//                               ),
//                             ]
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: counter == 2 ? Colors.teal : Colors.grey[300],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20,),
//                   Expanded(
//                     child: MaterialButton(
//                       onPressed: ()
//                       {
//                         setState(() {
//                           counter=3;
//                           buttom[counter];
//                         });
//                       },
//                       child: Container(
//                         key: right,
//                         width: 200,
//                         height: 200,
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children:[
//                               Icon(
//                                 Icons.arrow_forward_rounded,
//                                 size: 70.0,
//                               ),
//                               SizedBox(
//                                 height: 15.0,
//                               ),
//                               Text('Right',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25.0,
//                                 ),
//                               ),
//                             ]
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: counter == 3 ? Colors.teal : Colors.grey[300],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//               child: MaterialButton(
//                 onPressed: ()
//                 {
//                   setState(() {
//                     counter=1;
//                     buttom[counter];
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Container(
//                     key: back,
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: counter == 1 ? Colors.teal : Colors.grey[300],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Back',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25.0,
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         Icon(Icons.arrow_downward_rounded,size: 70.0,)
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'as prefix;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' ;
class eye extends StatefulWidget {

  @override
  State<eye> createState() => _eyeState();
}

class _eyeState extends State<eye> {

  bool direction = true;
  var forword;
  var back;
  var left;
  var right;
  List<String> buttom = ['forword', 'back', 'left', 'right'];
  var counter = 0;
  BluetoothConnection? connection;
  bool isConnected = false;

  void connectToArduino() async {
    try {
      BluetoothDevice device = await FlutterBluetoothSerial.instance
          .getBondedDevices()
          .then((List<BluetoothDevice> bondedDevices) {
        return bondedDevices.firstWhere(
                (device) => device.name == "HC-06");
      });
      if (device != null) {
        connection = await BluetoothConnection.toAddress(device.address);
        setState(() {
          isConnected = true;
        });
        print('Connected to the device');
        connection!.input!.listen((Uint8List data) {
          print('Data incoming: ${ascii.decode(data)}');
          connection!.output.add(data); // Sending data
          if (ascii.decode(data).contains('!')) {
            connection!.finish(); // Closing connection
            setState(() {
              isConnected = false;
            });
            print('Disconnected by local host');
          }
        }).onDone(() {
          setState(() {
            isConnected = false;
          });
          print('Disconnected by remote request');
        });
      }
    } catch (exception) {
      print('Cannot connect, exception occurred: $exception');
    }
  }

  Future<void> resetbluetooth() async {
    prefix.FlutterBluePlus.instance.turnOff();
    final timer = Timer(
      const Duration(seconds: 2),
          () {
        prefix.FlutterBluePlus.instance.turnOn();
        print('hello from Timer function');
      },
    );
  }

  void Stop() {
    if (isConnected) {
      String message = "S";
      connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      print('Data sent: $message');
    }
  }

  void Forward([bool is_onTap = false]) {
    if (isConnected) {
      String message = "F";
      connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      print('Data sent: $message');
      if(is_onTap){
        final timer = Timer(
            const Duration(seconds: 1),
                () {
              Stop();
              print('hello from Timer function in Forward timer');
            });
      }}
  }

  void Backward([bool is_onTap = false]) {
    if (isConnected) {
      String message = "B";
      connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      print('Data sent: $message');
      if (is_onTap) {
        final timer = Timer(
            const Duration(seconds: 1),
                () {
              Stop();
              print('hello from Timer function in Backword timer');
            });
      }
    }
  }

  void Left([bool is_onTap = false]) {
    if (isConnected) {
      String message = "L";
      connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      print('Data sent: $message');
      if (is_onTap) {
        final timer = Timer(
            const Duration(seconds: 1),
                () {
              Stop();
              print('hello from Timer function in Left timer');
            });
      }
    }}

  void Right([bool is_onTap = false]) {
    if (isConnected) {
      String message = "R";
      connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      print('Data sent: $message');
      if (is_onTap) {
        final timer = Timer(
            const Duration(seconds: 1),
                () {
              Stop();
              print('hello from Timer function in Right timer');
            });
      }
    }
  }


  @override
  void initState() {
    super.initState();
    resetbluetooth();
    final timer = Timer(
      const Duration(seconds: 3),
          () {
        connectToArduino();
        print('hello from Timer function in initstate');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isConnected ? 'Connected' : 'Disconnected',
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(onPressed: () {
                connectToArduino;
                setState(() {

                });
              }, child: Text("connect"))
            ],
          ),
          Expanded(
              child: GestureDetector(

                onLongPress: () {
                  Forward();
                  setState(() {
                    counter = 0;
                    buttom[counter];
                  });
                },
                onLongPressUp: ()=>Stop(),
                onTap: () {
                  Forward(true);
                  setState(() {
                    counter = 0;
                    buttom[counter];
                  });
                },

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    key: forword,
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: counter == 0 ? Colors.teal : Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Forword',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Icon(Icons.arrow_upward_rounded, size: 70.0,)
                      ],
                    ),
                  ),
                ),
              )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () {
                        Left();
                        setState(() {
                          counter = 2;
                          buttom[counter];
                        });
                      },
                      onLongPressUp: ()=>Stop(),
                      onTap: () {
                        Left(true);
                        setState(() {
                          counter = 2;
                          buttom[counter];
                        });
                      },

                      child: Container(
                        key: left,
                        width: 200,
                        height: 200,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back_rounded,
                                size: 70.0,
                              ),
                              SizedBox(
                                height: 15.0,

                              ),
                              Text('left',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                            ]
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: counter == 2 ? Colors.teal : Colors
                              .grey[300],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () {
                        Right();
                        setState(() {
                          counter = 3;
                          buttom[counter];
                        });
                      },
                      onLongPressUp: () {
                        Stop();
                      },
                      onTap: () {
                        Right(true);
                        setState(() {
                          counter = 3;
                          buttom[counter];
                        });
                      },
                      child: Container(
                        key: right,
                        width: 200,
                        height: 200,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 70.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text('Right',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                            ]
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: counter == 3 ? Colors.teal : Colors
                              .grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: GestureDetector(

                onLongPress: () {
                  Backward();
                  setState(() {
                    counter = 1;
                    buttom[counter];
                  });
                },
                onLongPressUp: () {
                  Stop();
                },
                onTap: () {
                  Backward(true);
                  setState(() {
                    counter = 1;
                    buttom[counter];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    key: back,
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: counter == 1 ? Colors.teal : Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Back',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Icon(Icons.arrow_downward_rounded, size: 70.0,)
                      ],
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}




