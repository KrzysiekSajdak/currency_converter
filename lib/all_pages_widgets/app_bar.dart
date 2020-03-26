import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

PreferredSizeWidget appBar({screenTitle}) {
  return Platform.isAndroid
      ? AppBar(
    title: Text(screenTitle),
  )
      : CupertinoNavigationBar(
    backgroundColor: Colors.black38,
    middle: Text(
      screenTitle,
      style: TextStyle(color: Colors.white),
    ),
  );
}
