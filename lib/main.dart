/*
Copyright 2021 The dahliaOS Authors
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'views/TerminalFrame.dart';

void main() {
  runApp(const Terminal());
}

class Terminal extends StatelessWidget {
  // Possible multi-theme switching later on.
  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepOrange,
    primaryColor: const Color(0xFF212121),
    accentColor: const Color(0xFFff6507), // TODO:
    canvasColor: const Color(0xFF303030),
    platform: TargetPlatform.fuchsia,
  );

  const Terminal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setWindowTitle("Terminal");
    return MaterialApp(
      title: 'Terminal',
      theme: darkMode,
      initialRoute: '/',
      routes: {
        '/': (context) => TerminalFrame(),
        // TODO: Implement Settings
        // '/settings': (context) => SettingsFrame(),
      },
    );
  }
}
