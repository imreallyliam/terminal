import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:terminal/views/terminal.dart';

class Interface extends StatefulWidget {
  const Interface({Key? key}) : super(key: key);

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    tabs = [const Icon(Icons.add)];
    pages = [];

    createTab("/bin/bash", "\$ ", const TerminalWidget());
  }

  late List<Widget> tabs;

  late List<Widget> pages;

  int createTab(title, subtitle, widget) {
    int index = max(tabs.length - 1, 0);
    tabs.insert(index, getTab(Key(generateRandomString(32)), title, subtitle));
    pages.insert(index, widget);
    return index;
  }

  void closeTab(key) {
    int index = tabs.indexWhere((element) => element.key == key);
    tabs.removeAt(index);
    pages.removeAt(index);
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Column(children: [
              WindowTitleBarBox(
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
                      if (index == tabs.length - 1) {
                        _selectedIndex = createTab(
                            "/bin/bash", "\$ ", const TerminalWidget());
                      } else {
                        _selectedIndex = index;
                      }
                    });
                  },
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  tabs: tabs,
                ),
              ),
            ),
          ),
          body: pages.isEmpty
              ? const Center(child: Text("It's time to start exploring"))
              : pages.elementAt(_selectedIndex),
        ));
  }

  Widget getTab(Key? key, String title, String subtitle) {
    return _Tab(
        key: key,
        title: title,
        subtitle: subtitle,
        onDoubleTap: () {
          setState(() {
            closeTab(key);
          });
        });
  }
}

// ignore: must_be_immutable
class _Tab extends StatefulWidget {
  _Tab({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onDoubleTap,
  }) : super(key: key);

  String title;
  String subtitle;
  final Function onDoubleTap;

  @override
  State<_Tab> createState() => _TabState();
}

class _TabState extends State<_Tab> {
  @override
  Widget build(BuildContext context) {
    String titleOG = widget.title;
    return GestureDetector(
      onTertiaryTapUp: (details) {
        widget.onDoubleTap();
      },
      onDoubleTap: () {
        showDialog(
            builder: (context) => AlertDialog(
                  title: const Text("Rename Tab"),
                  content: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: widget.title,
                    ),
                    onChanged: (value) {
                      if (value == "") {
                        widget.title = titleOG;
                      } else {
                        widget.title = value;
                      }
                      setState(() {});
                    },
                  ),
                  actions: [
                    TextButton(
                        autofocus: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Done"))
                  ],
                ),
            context: context);
      },
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                  style: const TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.bold)),
              Text(widget.subtitle, style: const TextStyle(fontSize: 12.0))
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close),
            iconSize: 20.0,
            splashRadius: 15.0,
            onPressed: () {
              widget.onDoubleTap();
            },
          )
        ],
      ),
    );
  }
}

String generateRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
}
