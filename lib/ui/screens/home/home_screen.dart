import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/common/resources/colors.dart';
import 'package:flutter_weather_app/common/resources/strings.dart';
import 'package:flutter_weather_app/ui/base/base_stateful_page.dart';
import 'package:flutter_weather_app/ui/screens/forecast/details/forecast_details.dart';
import 'package:flutter_weather_app/ui/screens/forecast/list/forecast_list_widget.dart';
import 'package:flutter_weather_app/ui/widgets/base_widget_tree.dart';
import 'package:flutter_weather_app/ui/widgets/default_divider.dart';
import 'package:flutter_weather_app/ui/widgets/unit_switcher/unit_switcher.dart';

import 'bloc/home_screen_bloc.dart';

HomeScreenBloc getHomeBloc(BuildContext context) =>
    BlocProvider.of<HomeScreenBloc>(context);

class HomeScreen extends BaseStatefulPage {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoadingVisible = false;
  String city;

  @override
  void initState() {
    super.initState();
    getHomeBloc(context).add(GetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetTree(
      title: city ?? Strings.city,
      widgetsAboveChild: [
        BlocListener<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) async {
            if (state is LoadingVisibilityState) {
              setState(() {
                isLoadingVisible = state.visible;
              });
            } else if (state is DataLoadedState) {
              if (state.success) {
                setState(() {
                  city = state.data.title;
                });
              } else {
                if (await widget.showNetworkErrorPopup(context))
                  getHomeBloc(context).add(GetDataEvent());
                setState(() {
                  city = Strings.error;
                });
              }
            }
          },
          child: Visibility(
            visible: isLoadingVisible,
            child: new LinearProgressIndicator(
                backgroundColor: COLOR_SECONDARY_DARK),
          ),
        )
      ],
      child: OrientationBuilder(builder: (context, orientation) {
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultDivider(),
                Expanded(
                  child: ForecastDetails(orientation),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: UnitSwitcher(orientation),
            ),
            Align(
              alignment: orientation == Orientation.portrait
                  ? Alignment.bottomLeft
                  : Alignment.topLeft,
              child: ForecastListWidget(orientation),
            ),
          ],
        );
      }),
    );
  }
}
