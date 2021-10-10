library colors;

import 'dart:ui';

import 'package:flutter/material.dart';

const Color COLOR_ACCENT = Color(0xff58B33B);
const Color COLOR_PRIMARY = Color(0xff58B33B);
const Color COLOR_PRIMARY_DARK = Color(0xff5f5f5f);
const Color COLOR_SECONDARY_DARK = Color(0xffA0A4B8);
const Color COLOR_BACKGROUND = Color(0xfff3f4f5);
const Color COLOR_FOREGROUND = Color(0xddFEFEFE);
const Color COLOR_APPBAR_ICON = Color(0xff000000);
const Color COLOR_APPBAR_ACTIONS_ICON = Color(0xff000000);

final MaterialColor COLOR_PRIMARY_SWATCH =
    MaterialColor(COLOR_ACCENT.hashCode, {
  50: COLOR_ACCENT.withOpacity(0.05),
  100: COLOR_ACCENT.withOpacity(0.1),
  200: COLOR_ACCENT.withOpacity(0.2),
  300: COLOR_ACCENT.withOpacity(0.3),
  400: COLOR_ACCENT.withOpacity(0.4),
  500: COLOR_ACCENT.withOpacity(0.5),
  600: COLOR_ACCENT.withOpacity(0.6),
  700: COLOR_ACCENT.withOpacity(0.7),
  800: COLOR_ACCENT.withOpacity(0.8),
  900: COLOR_ACCENT.withOpacity(0.9),
});
