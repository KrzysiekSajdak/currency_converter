import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

PreferredSizeWidget appBar({screenTitle}) {
  return AppBar(
    title: Text(screenTitle),
  );
}
