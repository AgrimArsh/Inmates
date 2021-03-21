import 'dart:ui';

import 'package:flutter/material.dart';

Color turquoise = Colors.blue;
Color green = Color(0xFF50C878);
LinearGradient gradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    turquoise,
    green,
  ],
);
DecorationImage bgImage = DecorationImage(
  fit: BoxFit.cover,
  image: AssetImage("images/sandBG.jpg")
);