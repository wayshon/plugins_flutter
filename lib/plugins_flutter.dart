import 'dart:async';

import 'package:flutter/services.dart';

class PluginsFlutter {
  static const MethodChannel _channel = const MethodChannel('plugins_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> get share async {
    final bool success = await _channel.invokeMethod('share', [
      {
        'text': '哈哈哈哈哈哈哈哈',
        'url': 'https://calcbit.com',
        'imageUrl': 'https://calcbit.com/resource/doudou/doudou.jpeg'
      }
    ]);
    return success;
  }
}
