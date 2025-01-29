import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  static const platform = MethodChannel('com.example.app/browser');

  Future<void> _openURL(String url) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await platform.invokeMethod('openBrowser', {'url': url});
      } else {
        throw "Unsupported platform";
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to open browser: ${e.message}");
      }
    }
  }

  Widget linkButton(String text, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => _openURL(url),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HNG Stage 0 Task')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            linkButton(
              'Checkout GitHub Repo',
              'https://github.com/Chukwuaebuka/stage-0-task',
            ),
            linkButton(
              'Hire Flutter Devs',
              'http://hng.tech/hire/flutter-developers',
            ),
            linkButton(
              'Hire React-Native Devs',
              'http://hng.tech/hire/react-native-developers',
            ),
            linkButton(
              'Checkout Telex',
              'https://telex.im/',
            ),
            linkButton(
              'Checkout Delve',
              'https://delve.fun/',
            ),
          ],
        ),
      ),
    );
  }
}
