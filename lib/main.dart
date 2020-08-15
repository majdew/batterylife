import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Battery life",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _batteryLevel;
  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel('batterylifeapp.flutter.dev/batterylevel');

    //send message  channel between flutter and platform
    // name of the method
    try {
      final batteryLevel = await platform.invokeMethod(
        'getBatteryLevel',
      );
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (error) {
      setState(() {
        _batteryLevel = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battery life"),
      ),
      body: Center(
        child: Text("Battery level : $_batteryLevel"),
      ),
    );
  }
}
