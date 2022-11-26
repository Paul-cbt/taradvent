import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setAppbarStyle(BuildContext context, {bool? optionalDarkMode}) {
  SystemChrome.setSystemUIOverlayStyle(
      getAppbarStyle(context, optionalDarkMode: optionalDarkMode));
}

SystemUiOverlayStyle getAppbarStyle(BuildContext context,
    {bool? optionalDarkMode}) {
  bool showDarkMode =
      optionalDarkMode ?? Theme.of(context).brightness == Brightness.dark;
  return SystemUiOverlayStyle(
      statusBarColor: showDarkMode
          ? Colors.black.withOpacity(0)
          : Colors.white.withOpacity(0),
      statusBarBrightness: showDarkMode ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          showDarkMode ? Brightness.light : Brightness.dark);
}
