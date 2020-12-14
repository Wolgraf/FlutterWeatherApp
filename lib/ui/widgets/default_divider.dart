import 'package:flutter/material.dart';
import 'package:flutter_weather_app/common/resources/colors.dart';

class DefaultDivider extends Container {
  final double horizontalMargin;
  final Color color;

  DefaultDivider({this.horizontalMargin = 0, this.color = COLOR_SECONDARY_DARK})
      : super(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin,
            ),
            width: double.infinity,
            height: 1.0,
            color: color);
}
