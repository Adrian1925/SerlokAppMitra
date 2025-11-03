import 'package:flutter/material.dart';

double get baseWidth =>
    MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.width;

double get baseHeight =>
    MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.height;


// next----
const double figmaWidth = 375; 
const double figmaHeight = 936;

double scaleWidth(double size) {
  return (size / figmaWidth) * baseWidth;
}

double scaleHeight(double size) {
  return (size / figmaHeight) * baseHeight;
}