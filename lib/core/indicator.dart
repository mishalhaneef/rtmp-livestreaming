import 'dart:io';
import 'package:flutter/material.dart';

Widget progressIndicator(Color color) {
  return Center(
    child: Platform.isIOS
        ? CircularProgressIndicator.adaptive(
            backgroundColor: color,
          )
        : SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: color),
          ),
  );
}
