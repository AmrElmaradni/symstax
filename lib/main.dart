import 'package:bot_toast/bot_toast.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:symstax/view/layout/event/controller/event_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'firebase_options.dart';
import 'helpers/routes/app_routers.dart';
import 'helpers/theme/app_theme_controller.dart';
import 'helpers/theme/style.dart';
import 'helpers/theme/theme_enum.dart';
import 'view/layout/auth/controller/auth_controller.dart';
import 'view/layout/on_boarding/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Hive.registerAdapter(ThemeEnumAdapter());
  await Hive.openBox('app');

  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'i18n',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: true,
      child: ChangeNotifierProvider(
        create: (context) => AppThemeController()..initial(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setMyAppState(BuildContext context) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setMyAppState();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void setMyAppState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => EventController()),
      ],
      child: MaterialApp(
        title: "Symstax",
        localizationsDelegates: [
          ...context.localizationDelegates,
          CountryLocalizations.delegate,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: appThemeData(context),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRouters.onGenerateRoute,
        navigatorKey: AppRouters.navigatorKey,
      ),
    );
  }
}

const testText =
    '''The Lorem ipum filling text is used by graphic designers, programmers and printers with the aim of occupying the spaces of a website, an advertising product or an editorial production whose final text is not yet ready.

This expedient serves to get an idea of the finished product that will soon be printed or disseminated via digital channels.

In order to have a result that is more in keeping with the final result, the graphic designers, designers or typographers report the Lorem ipsum text in respect of two fundamental aspects, namely readability and editorial requirements.

The choice of font and font size with which Lorem ipsum is reproduced answers to specific needs that go beyond the simple and simple filling of spaces dedicated to accepting real texts and allowing to have hands an advertising/publishing product, both web and paper, true to reality.

Its nonsense allows the eye to focus only on the graphic layout objectively evaluating the stylistic choices of a project, so it is installed on many graphic programs on many software platforms of personal publishing and content management system.

The Lorem ipum filling text is used by graphic designers, programmers and printers with the aim of occupying the spaces of a website, an advertising product or an editorial production whose final text is not yet ready.

This expedient serves to get an idea of the finished product that will soon be printed or disseminated via digital channels.

In order to have a result that is more in keeping with the final result, the graphic designers, designers or typographers report the Lorem ipsum text in respect of two fundamental aspects, namely readability and editorial requirements.

The choice of font and font size with which Lorem ipsum is reproduced answers to specific needs that go beyond the simple and simple filling of spaces dedicated to accepting real texts and allowing to have hands an advertising/publishing product, both web and paper, true to reality.

Its nonsense allows the eye to focus only on the graphic layout objectively evaluating the stylistic choices of a project, so it is installed on many graphic programs on many software platforms of personal publishing and content management system.''';
