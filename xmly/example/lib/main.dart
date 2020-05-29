import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:xmly/xmly.dart';
import 'package:xmly_example/api_manager.dart';

void main() {
  runApp(MyApp());
}

const bool isRelease = const bool.fromEnvironment("dart.vm.product");

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await Xmly.isDebug(isDebug: !isRelease);
      await Xmly.init(
        appKey: "857b7fc3d1ab3a0388f1c27a63f3ef85",
        packId: "com.stevie.xmly_example",
        appSecret: "21b73a1e994be13be6673b8d9d3a0151",
      );
      await Xmly.useHttps(useHttps: true);
      await Xmly.isTargetSDKVersion24More(isTargetSDKVersion24More: true);
      Timer(Duration(seconds: 2), () async {
        platformVersion = await ApiManager().getBannerList();
        if (mounted) {
          setState(() {
            _platformVersion = platformVersion;
          });
        }
      });
    } on PlatformException catch (e) {
      platformVersion = e.toString();
    } on Exception catch (e) {
      platformVersion = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
