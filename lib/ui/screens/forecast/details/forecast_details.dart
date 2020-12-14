import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_weather_app/common/resources/dimens.dart';
import 'package:flutter_weather_app/common/resources/text_styles.dart';
import 'package:flutter_weather_app/network/models/consolidated_weather.dart';
import 'package:flutter_weather_app/ui/screens/forecast/list/bloc/forecast_list_widget_bloc.dart';
import 'package:flutter_weather_app/ui/screens/home/bloc/home_screen_bloc.dart';
import 'package:flutter_weather_app/ui/screens/home/home_screen.dart';
import 'package:flutter_weather_app/ui/widgets/unit_switcher/bloc/unit_switcher_bloc.dart';
import 'package:flutter_weather_app/ui/widgets/unit_switcher/unit_switcher.dart';
import 'package:flutter_weather_app/ui/widgets/vertical_spacing.dart';

class ForecastDetails extends StatefulWidget {
  ForecastDetails(this.orientation);

  final Orientation orientation;

  @override
  State<StatefulWidget> createState() => _ForecastDetailsState();
}

class _ForecastDetailsState extends State<ForecastDetails> {
  ConsolidatedWeather object;
  Unit currentUnit = Unit.celsius;

  bool isPortrait() => widget.orientation == Orientation.portrait;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<ForecastListWidgetBloc, ForecastListWidgetState>(
            listener: (context, state) {
              if (state is CardSelectionState) {
                setState(() {
                  this.object = state.object;
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
          )
        ],
        child: LayoutBuilder(
          builder: (context, constraint) {
            return RefreshIndicator(
              onRefresh: () async => getHomeBloc(context).add(GetDataEvent()),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: object != null
                    ? ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: isPortrait()
                                    ? CARD_LIST_SIZE
                                    : DEFAULT_MARGIN,
                                top: DEFAULT_MARGIN,
                                left: isPortrait()
                                    ? DEFAULT_MARGIN
                                    : CARD_LIST_SIZE,
                                right: DEFAULT_MARGIN),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.all(DEFAULT_PADDING),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: SvgPicture.asset(
                                        object.weatherIconPath,
                                        width: isPortrait()
                                            ? ICON_SIZE_LARGE
                                            : ICON_SIZE_MEDIUM,
                                        height: isPortrait()
                                            ? ICON_SIZE_LARGE
                                            : ICON_SIZE_MEDIUM),
                                  ),
                                ),
                                Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(CARD_RADIUS),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(MEDIUM_PADDING),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    isPortrait()
                                                        ? object.dayOfTheWeek
                                                        : object
                                                            .dayOfTheWeekWithDate,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                    style:
                                                        TEXT_STYLE_HEADLINE_6,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    object.properWeatherName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                    style:
                                                        TEXT_STYLE_HEADLINE_6,
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: isPortrait(),
                                            child: Text(
                                              object.applicableDate,
                                              style: TEXT_STYLE_HEADLINE_4,
                                            ),
                                          ),
                                          const VerticalSpacing(),
                                          Text(
                                            currentUnit == Unit.celsius
                                                ? object.detailsTemperature
                                                : object.detailsTemperatureFhr,
                                            style: TEXT_STYLE_HEADLINE_4,
                                          ),
                                          const VerticalSpacing(
                                              height: MEDIUM_MARGIN),
                                          Text(
                                            object.properHumidity,
                                            style: TEXT_STYLE_HEADLINE_4,
                                          ),
                                          const VerticalSpacing(
                                              height: MEDIUM_MARGIN),
                                          Text(
                                            object.properPressure,
                                            style: TEXT_STYLE_HEADLINE_4,
                                          ),
                                          const VerticalSpacing(
                                              height: MEDIUM_MARGIN),
                                          Text(
                                            object.properWind,
                                            style: TEXT_STYLE_HEADLINE_4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(width: 0, height: 0),
              ),
            );
          },
        ));
  }
}
