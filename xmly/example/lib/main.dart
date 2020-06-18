import 'package:flutter/material.dart';
import 'package:xmly/xmly_plugin.dart';
import 'package:xmly_example/route/home_page.dart';

void main() {
  runApp(MyApp());
}

const bool isRelease = const bool.fromEnvironment("dart.vm.product");

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final xmly = Xmly();
  Future _future;

  @override
  void initState() {
    _initXmly();
    super.initState();
  }

  @override
  void dispose() {
    xmly.release();
    super.dispose();
  }

  _initXmly() async {
    _future = Future.wait([
      xmly.isDebug(isDebug: !isRelease),
      xmly.init(
        appKey: "857b7fc3d1ab3a0388f1c27a63f3ef85",
        packId: "com.stevie.xmly_example",
        appSecret: "21b73a1e994be13be6673b8d9d3a0151",
      ),
      xmly.useHttps(useHttps: true),
      xmly.isTargetSDKVersion24More(isTargetSDKVersion24More: true),
      Future.delayed(Duration(seconds: 1)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Container();
              } else {
                return HomePage();
              }
            } else {
              return Scaffold(
                appBar: AppBar(backgroundColor: Color(0xf0f0f0)),
                body: Container(
                  color: Color(0xf0f0f0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
