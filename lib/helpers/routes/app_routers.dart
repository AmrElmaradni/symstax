import 'package:flutter/material.dart';
import 'package:symstax/view/layout/event/screen/event_details_screen.dart';

import '../../view/custom_widgets/zoom_image/zoom_image_screen.dart';
import '../../view/layout/auth/screen/login_screen.dart';
import '../../view/layout/auth/screen/register_screen.dart';
import '../../view/layout/event/screen/events_screen.dart';
import '../../view/layout/event/screen/save_event_screen.dart';
import '../../view/layout/on_boarding/screen/splash_screen.dart';

class AppRouters {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    dynamic args;
    if (settings.arguments != null) args = settings.arguments;
    switch (settings.name) {
      case ZoomImageScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ZoomImageScreen(
            args: args,
          ),
        );
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case EventsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const EventsScreen(),
        );
      case SaveEventScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SaveEventScreen(
            args: args,
          ),
        );
      case EventDetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => EventDetailsScreen(
            event: args,
          ),
        );
      default:
        return null;
    }
  }
}
