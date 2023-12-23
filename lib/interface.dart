import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:terminal/tabs.dart';
import 'package:terminal/views/terminal.dart';
import 'package:terminal/views/welcome.dart';

class Interface extends StatefulWidget {
  const Interface({Key? key}) : super(key: key);

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  @override
  void initState() {
    super.initState();
    Tabs.interfaceSetState = () {
      setState(() {});
    };
  }

  // TODO: comment code
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: Tabs.tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Column(children: [
              WindowTitleBarBox(
                  // MoveWindow comes from bitsdojo_window package -- allows custom draggable topbar.
                  child: MoveWindow(
                child: const Text('Terminal'),
              )),
            ]),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      if (index == Tabs.tabs.length - 1) {
                        // TODO: name based on open app. subtitle based on app given name
                        Tabs.createTab(
                            "/bin/bash", "\$ ", const TerminalWidget());
                      } else {
                        Tabs.selectedIndex = index;
                      }
                    });
                  },
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  tabs: Tabs.tabs,
                ),
              ),
            ),
          ),
          body: Tabs.pages.isEmpty
              ? const Welcome()
              : Tabs.pages.elementAt(Tabs.selectedIndex),
        ));
  }
}
