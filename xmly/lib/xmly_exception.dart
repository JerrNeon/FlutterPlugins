import 'package:flutter/widgets.dart';

class XmlyException implements Exception {
  XmlyException({
    @required this.code,
    this.message,
  });

  /// An error code.
  final String code;

  /// A human-readable error message, possibly null.
  final String message;

  @override
  String toString() => 'XmlyException($code, $message)';
}
