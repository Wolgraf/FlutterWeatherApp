import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/ui/screens/forecast/list/bloc/forecast_list_widget_bloc.dart';
import 'package:flutter_weather_app/ui/screens/home/home_screen.dart';
import 'package:flutter_weather_app/ui/widgets/unit_switcher/bloc/unit_switcher_bloc.dart';

import 'common/resources/colors.dart';
import 'common/resources/strings.dart';
import 'common/resources/text_styles.dart';
import 'network/repository/forecast/forecast_repository.dart';
import 'ui/screens/home/bloc/home_screen_bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: COLOR_PRIMARY_DARK,
      systemNavigationBarColor: COLOR_PRIMARY_DARK));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => HomeScreenBloc(repository: ForecastRepository())),
        BlocProvider(create: (_) => ForecastListWidgetBloc()),
        BlocProvider(create: (_) => UnitSwitcherBloc()),
      ],
      child: MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            brightness: Brightness.light,
            elevation: 0,
            textTheme: TextTheme(headline6: TEXT_STYLE_HEADLINE_6),
            iconTheme: IconThemeData(color: COLOR_APPBAR_ICON),
            actionsIconTheme: IconThemeData(color: COLOR_APPBAR_ACTIONS_ICON),
          ),
          buttonBarTheme: const ButtonBarThemeData(),
          scaffoldBackgroundColor: COLOR_BACKGROUND,
          splashColor: Colors.white,
          splashFactory: InkRipple.splashFactory,
          brightness: Brightness.light,
          primaryColor: COLOR_PRIMARY,
          accentColor: COLOR_ACCENT,
          fontFamily: Strings.fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
