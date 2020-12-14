import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_weather_app/common/resources/colors.dart';
import 'package:flutter_weather_app/common/resources/dimens.dart';
import 'package:flutter_weather_app/common/resources/text_styles.dart';
import 'package:flutter_weather_app/network/models/consolidated_weather.dart';
import 'package:flutter_weather_app/ui/screens/forecast/list/bloc/forecast_list_widget_bloc.dart';
import 'package:flutter_weather_app/ui/screens/home/bloc/home_screen_bloc.dart';
import 'package:flutter_weather_app/ui/widgets/unit_switcher/bloc/unit_switcher_bloc.dart';
import 'package:flutter_weather_app/ui/widgets/unit_switcher/unit_switcher.dart';
import 'package:flutter_weather_app/ui/widgets/vertical_spacing.dart';

class ForecastListWidget extends StatefulWidget {
  ForecastListWidget(this.orientation);

  final Orientation orientation;

  @override
  State<StatefulWidget> createState() => _ForecastListWidgetState();
}

class _ForecastListWidgetState extends State<ForecastListWidget> {
  List<ConsolidatedWeather> consolidatedWeatherList;
  int selectedIndex = 0;
  Unit currentUnit = Unit.celsius;

  bool hasData() =>
      consolidatedWeatherList != null && consolidatedWeatherList.isNotEmpty;

  bool isPortrait() => widget.orientation == Orientation.portrait;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (state is DataLoadedState) {
              if (state.success) {
                setState(() {
                  consolidatedWeatherList = state.data.consolidatedWeather;
                });
                if (hasData())
                  BlocProvider.of<ForecastListWidgetBloc>(context).add(
                      CardSelectionEvent(consolidatedWeatherList.first, 0));
              }
            }
          },
        ),
        BlocListener<ForecastListWidgetBloc, ForecastListWidgetState>(
          listener: (context, state) {
            if (state is CardSelectionState) {
              setState(() {
                selectedIndex = state.index;
              });
            }
          },
        ),
        BlocListener<UnitSwitcherBloc, UnitSwitcherState>(
          listener: (context, state) {
            if (state is UnitSelectionState) {
              setState(() {
                currentUnit = state.unit;
              });
            }
          },
        ),
      ],
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        firstChild: _getListWidget(),
        secondChild: SizedBox(width: 0, height: 0),
        crossFadeState:
            hasData() ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }

  Widget _getListWidget() {
    return SizedBox(
      height: isPortrait() ? CARD_LIST_SIZE : double.infinity,
      width: isPortrait() ? double.infinity : CARD_LIST_SIZE,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: isPortrait() ? Axis.horizontal : Axis.vertical,
        itemCount: hasData() ? consolidatedWeatherList.length : 0,
        itemBuilder: (context, index) {
          final object = consolidatedWeatherList[index];
          return Container(
            width: CARD_LIST_SIZE,
            height: CARD_LIST_SIZE,
            margin: EdgeInsets.only(
                bottom: MEDIUM_MARGIN, left: THIN_MARGIN, right: THIN_MARGIN),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ForecastListWidgetBloc>(context)
                    .add(CardSelectionEvent(object, index));
              },
              child: Card(
                color: COLOR_FOREGROUND,
                elevation: CARD_ELEVATION,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(CARD_RADIUS),
                    side: selectedIndex == index
                        ? const BorderSide(
                            color: COLOR_ACCENT,
                            width: CARD_SELECTED_BORDER_WIDTH)
                        : const BorderSide(color: COLOR_PRIMARY_DARK)),
                child: Padding(
                  padding: EdgeInsets.all(DEFAULT_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              object.dayOfTheWeekAbb,
                              style: TEXT_STYLE_HEADLINE_6,
                            ),
                          ),
                          _getImageWidget(object),
                        ],
                      ),
                      VerticalSpacing(),
                      Text(
                        currentUnit == Unit.celsius
                            ? object.cardTemperatures
                            : object.cardTemperaturesFhr,
                        style: TEXT_STYLE_HEADLINE_4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _getImageWidget(ConsolidatedWeather object) => hasData()
      ? SvgPicture.asset(object.weatherIconPath,
          width: ICON_SIZE_NORMAL, height: ICON_SIZE_NORMAL)
      : SizedBox(width: 0, height: 0);
}
