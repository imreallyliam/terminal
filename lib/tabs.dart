import 'dart:math';

import 'package:flutter/material.dart';

class Tabs {
  static int selectedIndex = 0;
  // Only one interface can exist... in theory.
  static Function interfaceSetState = () {};
  static final List<Widget> _tabs = [const Icon(Icons.add)];
  static final List<Widget> _pages = [];

  //**
  //  Create new tab with given title, subtitle, and widget.
  //  Random key manually generated for tab management.
  // */
  static void createTab(String title, String subtitle, Widget widget) {
    int index = max(_tabs.length - 1, 0);
    _tabs.insert(
        index, _getTab(Key(generateRandomString(32)), title, subtitle));
    // TODO: assign specific key to the page for easier recall.
    _pages.insert(index, widget);
    selectedIndex = index;
    interfaceSetState();
  }

  static void closeTab(key) {
    int index = _tabs.indexWhere((element) => element.key == key);
    _tabs.removeAt(index);
    _pages.removeAt(index);
    selectedIndex = 0;
    interfaceSetState();
  }

  static List<Widget> get tabs => _tabs;
  static List<Widget> get pages => _pages;

  static Widget _getTab(Key? key, String title, String subtitle) {
    return _Tab(
        key: key,
        title: title,
        subtitle: subtitle,
        closeFn: () {
          closeTab(key);
        });
  }
}

// ignore: must_be_immutable
class _Tab extends StatefulWidget {
  _Tab({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.closeFn,
  }) : super(key: key);

  String title;
  String subtitle;
  final Function closeFn;

  @override
  State<_Tab> createState() => _TabState();
}

// TODO: reduce detectors used to improve speed.
// TODO: ability to change title & subtitle more dynamically.
// TODO: comment code
class _TabState extends State<_Tab> {
  @override
  Widget build(BuildContext context) {
    String titleOG = widget.title;
    return GestureDetector(
      onTertiaryTapUp: (details) {
        widget.closeFn();
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
              Text(widget.subtitle,
                  style: const TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.normal))
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close),
            iconSize: 20.0,
            splashRadius: 15.0,
            onPressed: () {
              widget.closeFn();
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
