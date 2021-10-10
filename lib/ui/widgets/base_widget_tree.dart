import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/common/resources/strings.dart';

class BaseWidgetTree extends StatelessWidget {
  BaseWidgetTree(
      {this.title, this.appBar, this.widgetsAboveChild, @required this.child})
      : assert(child != null);

  final String? title;
  final AppBar? appBar;
  final List<Widget>? widgetsAboveChild;
  final Widget? child;
  final List<Widget> mStack = [];

  @override
  Widget build(BuildContext context) {
    var mChild = child ?? Text(Strings.error);
    mStack.add(mChild);
    if (widgetsAboveChild != null && widgetsAboveChild!.isNotEmpty)
      mStack.addAll(widgetsAboveChild!);
    return Scaffold(
      appBar: _getAppbar(title, appBar),
      body: SafeArea(
        child: Stack(
          children: mStack,
        ),
      ),
    );
  }

  AppBar? _getAppbar(String? title, AppBar? appBar) {
    if (title == null && appBar == null)
      return null;
    else if (appBar == null && title != null)
      return AppBar(
        title: Text(title),
        centerTitle: true,
        brightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      );
    else
      return appBar;
  }
}
