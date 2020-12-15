import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/common/resources/colors.dart';
import 'package:flutter_weather_app/common/resources/constants.dart';
import 'package:flutter_weather_app/common/resources/dimens.dart';
import 'package:flutter_weather_app/common/resources/text_styles.dart';

import 'bloc/unit_switcher_bloc.dart';

enum Unit { celsius, fahrenheit }

getBloc(context) => BlocProvider.of<UnitSwitcherBloc>(context);

class UnitSwitcher extends StatefulWidget {
  UnitSwitcher(this.orientation);

  final Orientation orientation;

  @override
  State<StatefulWidget> createState() => _UnitSwitcherState();
}

class _UnitSwitcherState extends State<UnitSwitcher> {
  Unit _currentUnit = Unit.celsius;

  bool isPortrait() => widget.orientation == Orientation.portrait;

  @override
  void initState() {
    super.initState();
    getBloc(context).add(UnitSelectionEvent(Unit.celsius));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UnitSwitcherBloc, UnitSwitcherState>(
      listener: (context, state) {
        if (state is UnitSelectionState) {
          setState(() {
            _currentUnit = state.unit;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            bottom: isPortrait()
                ? CARD_LIST_SIZE + DEFAULT_PADDING
                : DEFAULT_PADDING,
            right: THIN_MARGIN),
        child: Card(
          color: COLOR_FOREGROUND,
          elevation: CARD_ELEVATION,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CARD_RADIUS),
              side: const BorderSide(color: COLOR_PRIMARY_DARK)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () =>
                    getBloc(context).add(UnitSelectionEvent(Unit.celsius)),
                child: Padding(
                  padding: const EdgeInsets.all(MEDIUM_PADDING),
                  child: Text(
                    UNIT_CELSIUS,
                    style: _currentUnit == Unit.celsius
                        ? TEXT_STYLE_HEADLINE_6_ACCENT
                        : TEXT_STYLE_HEADLINE_6,
                  ),
                ),
              ),
              Text('/', style: TEXT_STYLE_HEADLINE_6),
              GestureDetector(
                onTap: () =>
                    getBloc(context).add(UnitSelectionEvent(Unit.fahrenheit)),
                child: Padding(
                  padding: const EdgeInsets.all(MEDIUM_PADDING),
                  child: Text(
                    UNIT_FAHRENHEIT,
                    style: _currentUnit == Unit.fahrenheit
                        ? TEXT_STYLE_HEADLINE_6_ACCENT
                        : TEXT_STYLE_HEADLINE_6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
