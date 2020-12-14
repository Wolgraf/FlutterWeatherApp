library text_styles;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/common/resources/strings.dart';

import 'colors.dart';
import 'dimens.dart';

///14 medium
const TextStyle TEXT_STYLE_HEADLINE_4 = TextStyle(
    fontSize: FONT_SIZE_NORMAL,
    fontFamily: Strings.fontFamily,
    fontWeight: FontWeight.w500,
    color: Colors.black);

/// 20 medium
const TextStyle TEXT_STYLE_HEADLINE_6 = TextStyle(
    fontSize: FONT_SIZE_MEDIUM_PLUS,
    fontFamily: Strings.fontFamily,
    fontWeight: FontWeight.w500,
    color: Colors.black);

/// 20 medium accent
const TextStyle TEXT_STYLE_HEADLINE_6_ACCENT = TextStyle(
    fontSize: FONT_SIZE_MEDIUM_PLUS,
    fontFamily: Strings.fontFamily,
    fontWeight: FontWeight.w500,
    color: COLOR_ACCENT);
