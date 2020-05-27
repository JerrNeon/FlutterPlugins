import 'dart:async';

import 'package:flutter/services.dart';

class Xmly {
  static const MethodChannel _channel =
      const MethodChannel('xmly');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
