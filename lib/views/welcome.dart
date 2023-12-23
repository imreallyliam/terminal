import 'package:flutter/material.dart';
import 'package:terminal/tabs.dart';
import 'package:terminal/views/terminal.dart';
import 'package:zenit_ui/zenit_ui.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
        children: [
          ZenitButton(
            child: const SizedBox(
              width: 200,
              child: Center(
                child: Text("New Session"),
              ),
            ),
            onPressed: () {
              Tabs.createTab("/bin/bash", "\$ ", const TerminalWidget());
            },
          ),
          const SizedBox(height: 20),
          ZenitButton(
            child: const SizedBox(
              width: 200,
              child: Center(
                child: Text("Open Settings"),
              ),
            ),
            onPressed: () {
              //TODO: Change to settings widget when available
              Tabs.createTab("/bin/bash", "\$ ", const TerminalWidget());
            },
          ),
        ],
      ),
    );
  }
}
