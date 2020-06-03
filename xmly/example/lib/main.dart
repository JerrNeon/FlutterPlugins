import 'package:flutter/material.dart';
import 'dart:async';

import 'package:xmly/xmly.dart';
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

  @override
  void initState() {
    super.initState();
    initXmly();
  }

  Future initXmly() async {
    await Xmly.isDebug(isDebug: !isRelease);
    await Xmly.init(
      appKey: "857b7fc3d1ab3a0388f1c27a63f3ef85",
      packId: "com.stevie.xmly_example",
      appSecret: "21b73a1e994be13be6673b8d9d3a0151",
    );
    await Xmly.useHttps(useHttps: true);
    await Xmly.isTargetSDKVersion24More(isTargetSDKVersion24More: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
